Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k46IuEPj012424
	for <selinux@tycho.nsa.gov>; Sat, 6 May 2006 14:56:14 -0400
Received: from authusersmtp.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k46IuDAD014794
	for <selinux@tycho.nsa.gov>; Sat, 6 May 2006 18:56:14 GMT
Message-ID: <445CF147.1000300@cornell.edu>
Date: Sat, 06 May 2006 14:56:07 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@tresys.com>
CC: selinux <selinux@tycho.nsa.gov>, selinux-dev <selinux-dev@tresys.com>
Subject: Re: [PATCH] fix warnings in selinux-usr
References: <1146845884.2208.15.camel@jackjack.columbia.tresys.com>
In-Reply-To: <1146845884.2208.15.camel@jackjack.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> Steve,
>
> Attached is a patch that fixes many warnings that have crept into the
> selinux-usr code over time, making it difficult to ascertain whether
> code changes have introduced new warnings.
>   
record_policydb_table_t SEMANAGE_PORT_POLICYDB_RTABLE = {

 	.add         = NULL, 
-	.modify      = sepol_port_modify,
+	.modify      = (record_policydb_table_modify_t)sepol_port_modify,
 	.set         = NULL, 
-	.query       = sepol_port_query,
-        .count       = sepol_port_count,
-	.exists      = sepol_port_exists,
-	.iterate     = sepol_port_iterate,
+	.query       = (record_policydb_table_query_t)sepol_port_query,
+        .count       = (record_policydb_table_count_t)sepol_port_count,
+	.exists      = (record_policydb_table_exists_t)sepol_port_exists,
+	.iterate     = (record_policydb_table_iterate_t)sepol_port_iterate,
 };


The semanage <--> sepol record key/data are not necessarily identical, 
and that's why warnings occur on query, modify, etc... 
Changing the type to void* removes the warning, without fixing the 
potential problem. The cast is marked unsafe, because it is unsafe. A 
better solution would be to add conversion functions from semanage 
key/record to sepol key/record and vice versa.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
