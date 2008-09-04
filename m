Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m84D78Cj029342
	for <selinux@tycho.nsa.gov>; Thu, 4 Sep 2008 09:07:08 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m84D77k3021475
	for <selinux@tycho.nsa.gov>; Thu, 4 Sep 2008 13:07:08 GMT
Message-ID: <48BFDD4C.50105@redhat.com>
Date: Thu, 04 Sep 2008 09:06:20 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Robert Story <rstory@sparta.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: setroubleshoot problems with MLS policy in enforcing mode
References: <20080827155839.08c93565@sparta.com>
In-Reply-To: <20080827155839.08c93565@sparta.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Robert Story wrote:
> Hi,
> 
> I'm having some issues with enforcing mode for the MLS policy. I've
> been able to get around a few issues by simply feeding avcs through
> audit2allow, but this is and MLS range issue, so I think something else
> is needed...  Here is the AVC
> 
> type=AVC msg=audit(1219865658.259:224923): avc:  denied  { write } for  pid=1332 comm="audispd" path="socket:[7463]" dev=sockfs ino=7463 scontext=system_u:system_r:audisp_t:s15:c0.c1023 tcontext=system_u:system_r:audisp_t:s0-s15:c0.c1023 tclass=unix_stream_socket
> 
> This message is repeated quite frequently, driving the load up and
> filling the log file. The audispd processing is running at SystemHigh,
> and I haven't found a way to kill it without dropping to permissive
> mode. (Any suggestions on that appreciated as well.. "newrole -r
> sysadm_t; newrole -l s15; kill 1332" didn't work..)
> 
> I'm wondering if audisp/setroubleshoot are needed for auditing to work,
> or if they are helps for X applications, in which case they aren't
> needed at all, since X doesn't run in MLS enforcing.
> 
> 
They are not needed for auditing to work.  I am not sure setroubleshoot
would even be legal in an MLS environment since it could leak sensitive
information.

If you add a module with

policy_module(myaudit, 1.0)
gen_require(`
	type audisp_t;
')

mls_socket_write_all_levels(audisp_t)

Does this solve the problem?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
