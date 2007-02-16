Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1G5YYii029061
	for <selinux@tycho.nsa.gov>; Fri, 16 Feb 2007 00:34:34 -0500
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1G5Zmqp004886
	for <selinux@tycho.nsa.gov>; Fri, 16 Feb 2007 05:35:48 GMT
Received: by py-out-1112.google.com with SMTP id a78so425701pyh
        for <selinux@tycho.nsa.gov>; Thu, 15 Feb 2007 21:35:41 -0800 (PST)
Message-ID: <45D542A4.2030607@kaigai.gr.jp>
Date: Fri, 16 Feb 2007 14:35:32 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: jbrindle@tresys.com, russell@coker.com.au
Subject: [RFC] Security design of SE-PostgreSQL (1/3)
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

In recent days, I'm making progress in development of SE-PostgreSQL.
I found some issues on the work.
The followings are the issues and solutions which I planed to take.
I want any comment, idea and suggestion.


1. about Binary large object

PostgreSQL has some interfaces of binary large object.
lo_import() and lo_export() is arguable in them.
  definiton:
      lo_import(text 'file_name')
      lo_export(Oid blob_id, text 'file_name')

lo_import() imports a file specified with 'file_name' into PostgreSQL as
a binary large object. lo_export() export a binary large object specified
with blob_id into a file specified with 'file_name'.

'file_name' is a path name on the server side filesystem, not a client side.
Thus, this action is handled as an interaction between PostgreSQL server
process and a general file on the filesystem by the in-kernel SELinux,
although it was done for the client process's request.
In the result, unexpected downgrade/upgrade is easily happen.

The hardest one is labeling behavior for the newly generated files.
If we allows SE-PostgreSQL setfscreatecon() for them, it have to have enough
permission set for any clients. I think it's not a happy situation.

Now I have an idea to resolve the issue by adding new access vectors which
are blob:{import export}. I treated lo_import() and lo_export() as
an aggregation of three data flows.
In lo_export() cases, the first of them is the flow a blob to a client,
the second is a client to the server (SE-PostgreSQL) and the third is the
server to the filesystem.

client <---(blob:read)----- BLOB
  |
  +-------(blob:export)---> SE-PostgreSQL ---(file:write)---> 'file_name'

i.e, The 'blob:export' means to allow a data flow from a client process
to the server process via binary large object.

In the security policy, it can be described such as:
  allow httpd_sys_script_t postgresql_t : blob {import export} ;


You can obtain the latest SE-PostgreSQL source code from:
    http://code.google.com/p/sepgsql/source
and the sample security policy is here:
    http://www.kaigai.gr.jp/pub/selinux-policy-2.5.2-5.sepgsql.src.rpm

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
