Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m03FFnRK032355
	for <selinux@tycho.nsa.gov>; Thu, 3 Jan 2008 10:15:49 -0500
Received: from vidle.i.cz (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m03FFlAY006581
	for <selinux@tycho.nsa.gov>; Thu, 3 Jan 2008 15:15:48 GMT
Date: Thu, 3 Jan 2008 16:15:46 +0100
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: tmiller@tresys.com
Cc: selinux@tycho.nsa.gov
Subject: Re: PATCH: peersid capability support
Message-ID: <20080103151546.GA2837@bobek.pm.i.cz>
References: <200711291927.lATJRixF021978@rawhidevm-targeted.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
In-Reply-To: <200711291927.lATJRixF021978@rawhidevm-targeted.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Nov 29, 2007 at 02:27:44PM -0500, tmiller@tresys.com wrote:
> This is a reworking of the peersid capability patch Joshua sent out
> a few weeks ago.  This version requires added explicit declaration of
> capabilities in the policy.
> 
> I've used the same strings that Paul's kernel diff used (there is
> currently just a single capability).
>...

a prototype line for define_polcap() is missing.

zito@bobek:/tmp/checkpolicy-2.0.7$ make
cc -g -Wall -O2 -pipe -fno-strict-aliasing -I. -I/usr/include -o checkpolicy.o -c checkpolicy.c
yacc -d policy_parse.y
cc -g -Wall -O2 -pipe -fno-strict-aliasing -I. -I/usr/include -o y.tab.o -c y.tab.c
policy_parse.y: In function 'yyparse':
policy_parse.y:772: warning: implicit declaration of function 'define_polcap'
policy_parse.y: At top level:
policy_parse.y:972: error: static declaration of 'define_polcap' follows non-static declaration
policy_parse.y:772: error: previous implicit declaration of 'define_polcap' was here
make: *** [y.tab.o] Error 1

Attached is a patch with the prototypee...
Regards
-- 
Zito

--dDRMvlgZJXvWKvBx
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="checkpolicy.proto.patch"

Index: policy_parse.y
===================================================================
--- policy_parse.y	(revision 2717)
+++ policy_parse.y	(working copy)
@@ -125,6 +125,7 @@
 static int define_netif_context(void);
 static int define_ipv4_node_context(void);
 static int define_ipv6_node_context(void);
+static int define_polcap(void);
 
 typedef int (* require_func_t)();
 

--dDRMvlgZJXvWKvBx--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
