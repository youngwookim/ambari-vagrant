########################
# create the BLUEPRINT
########################
curl -H "X-Requested-By: ambari" -u admin:admin http://c6401:8080/api/v1/blueprints/multi-node-hdfs-yarn -d @- <<EOF
{
  "host_groups" : [
    {
      "name" : "master",
      "components" : [
      {
        "name" : "NAMENODE"
      },
      {
        "name" : "SECONDARY_NAMENODE"
      },       
      {
        "name" : "RESOURCEMANAGER"
      },
      {
        "name" : "HISTORYSERVER"
      },
      {
        "name" : "ZOOKEEPER_SERVER"
      },
      {
        "name" : "GANGLIA_SERVER"
      },
      {
        "name" : "GANGLIA_MONITOR"
      },
      {
        "name" : "APP_TIMELINE_SERVER"
      }
      ],
      "cardinality" : "1"
    },
    {
      "name" : "slaves",
      "components" : [
      {
        "name" : "DATANODE"
      },
      {
        "name" : "HDFS_CLIENT"
      },
      {
        "name" : "NODEMANAGER"
      },
      {
        "name" : "YARN_CLIENT"
      },
      {
        "name" : "MAPREDUCE2_CLIENT"
      },
      {
        "name" : "ZOOKEEPER_CLIENT"
      },
      {
        "name" : "GANGLIA_MONITOR"
      }
      ],
      "cardinality" : "2"
    }
  ],
  "Blueprints" : {
    "blueprint_name" : "multi-node-hdfs-yarn",
    "stack_name" : "HDP",
    "stack_version" : "2.2"
  }
}
EOF

########################
# create the cluster
########################

curl -H "X-Requested-By: ambari" -u admin:admin http://c6401:8080/api/v1/clusters/MyThreeNodeCluster -d @- <<EOF
{
  "blueprint" : "multi-node-hdfs-yarn",
  "host-groups" :[
    {
      "name" : "master", 
      "hosts" : [         
        {
          "fqdn" : "c6401.ambari.apache.org"
        }
      ]
    },
    {
      "name" : "slaves", 
      "hosts" : [
        {
          "fqdn" : "c6402.ambari.apache.org"
        },
        {
          "fqdn" : "c6403.ambari.apache.org"
        }
      ]
    }
  ]
}
EOF
