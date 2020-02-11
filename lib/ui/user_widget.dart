import 'package:anything/model/user.dart';
import 'package:anything/model/user_response.dart';
import 'package:anything/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class UserWidget extends StatefulWidget {
  @override
  _UserWidgetState createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    bloc.getUser();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshKey.currentState.show());
  }

  Future _refresh() {
    return bloc.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      color: Colors.cyan,
      key: _refreshKey,
      onRefresh: _refresh,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: StreamBuilder<UserResponse>(
              stream: bloc.subject.stream,
              builder: (context, AsyncSnapshot<UserResponse> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.error != null &&
                      snapshot.data.error.length > 0) {
                    return _buildErrorWidget(snapshot.data.error);
                  }
                  return _buildUserWidget(snapshot.data);
                } else if (snapshot.hasError) {
                  return _buildErrorWidget(snapshot.error);
                } else {
                  return _buildLoadingWidget();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
          ),
          SizedBox(height: 8.0),
          Text(
            'Loading data from API...',
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        children: <Widget>[
          Icon(
            Icons.info_outline,
            size: 32.0,
            color: Colors.white,
          ),
          SizedBox(height: 16.0),
          Text(
            'Error occured: $error',
            style: TextStyle(
              fontSize: 16.0,
              letterSpacing: 1.0,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildUserWidget(UserResponse data) {
    User user = data.results[0];
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(user.picture.large),
              backgroundColor: Colors.white,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  offset: Offset(0, 10),
                  color: Colors.cyanAccent,
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            '${StringUtils.capitalize(user.name.first)} ${StringUtils.capitalize(user.name.last)}',
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(height: 8.0),
          Text(
            '${user.email}',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          SizedBox(height: 8.0),
          Text(
            user.location.street.name +
                ', ' +
                user.location.street.number.toString(),
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(height: 8.0),
          Text(
            user.location.city,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(height: 8.0),
          Text(
            user.location.state,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
