Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2PLFCsj020029
	for <selinux@tycho.nsa.gov>; Sun, 25 Mar 2012 17:15:12 -0400
Received: by lahc1 with SMTP id c1so3920854lah.12
        for <selinux@tycho.nsa.gov>; Sun, 25 Mar 2012 14:15:11 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 25 Mar 2012 23:15:11 +0200
Message-ID: <CADyhKSULha+pSsYezFH5-ebHchv3FaVTjM4sJCEUae4c26dBLA@mail.gmail.com>
Subject: [2/4] sepgsql - foreign data wrapper support
From: Kohei KaiGai <kaigai@kaigai.gr.jp>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: refpolicy@oss1.tresys.com, SELinux-NSA <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch enables to transmit security label of the client to the
foreign database servers behalf on the primary server being
connected by the client process.

FDW (foreign data wrapper) is a feature that allows to define virtual
tables connected to remote servers, and handle queries to the remote
servers via the virtual table as if local queries.
If and when the virtual relation (managed by a particular connector
module; like pgsql_fdw, oracle_fdw, ...) is referenced, pgsql gives
a control to the connector module, then it opens the connection to
remote server to run a query.

This patch (conditionally) allows postgresql_t domain to set sockcreate
attribute, and it eventually enables to transmit security label of the
original client process to the remote node.
It is necessary feature to stack multiple sepgsql servers using FDW.

Thanks,

 Signed-off-by: KaiGai Kohei <kohei.kaigai@emea.nec.com>
--
 policy/modules/services/postgresql.te |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/policy/modules/services/postgresql.te
b/policy/modules/services/postgresql.te
index 2457d10..add0cd6 100644
--- a/policy/modules/services/postgresql.te
+++ b/policy/modules/services/postgresql.te
@@ -32,6 +32,13 @@ gen_tunable(sepgsql_enable_users_ddl, true)
 ## </desc>
 gen_tunable(sepgsql_unconfined_dbadm, true)

+## <desc>
+## <p>
+## Allow transmit client label to foreign database
+## </p>
+## </desc>
+gen_tunable(sepgsql_transmit_client_label, false)
+
 type postgresql_t;
 type postgresql_exec_t;
 init_daemon_domain(postgresql_t, postgresql_exec_t)
@@ -231,6 +238,9 @@ allow postgresql_t self:udp_socket
create_stream_socket_perms;
 allow postgresql_t self:unix_dgram_socket create_socket_perms;
 allow postgresql_t self:unix_stream_socket create_stream_socket_perms;
 allow postgresql_t self:netlink_selinux_socket create_socket_perms;
+tunable_policy(`sepgsql_transmit_client_label',`
+	allow postgresql_t self:process { setsockcreate };
+')

 allow postgresql_t sepgsql_database_type:db_database *;
 type_transition postgresql_t postgresql_t:db_database
sepgsql_db_t;		# deprecated

-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
