Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6CD55rT001700
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2004 09:05:05 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6CD50PJ008457
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2004 13:05:01 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: device_type vs file_type
Date: Mon, 12 Jul 2004 23:04:55 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200407111900.33374.russell@coker.com.au> <1089637167.22449.49.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1089637167.22449.49.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_3xo8AaumR6y0r4x"
Message-Id: <200407122304.55190.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_3xo8AaumR6y0r4x
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, 12 Jul 2004 22:59, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> On Sun, 2004-07-11 at 05:00, Russell Coker wrote:
> > The attached patch removes the file_type attribute from the types for
> > device nodes.
> >
> > In most cases rules using file_type are not intended to catch the types
> > for device nodes as well so this should make things simpler.
>
> Likely requires an audit of all uses of file_type in the policy, e.g.
> setfiles assumes file_type includes device node types as well.

The attached patch should be all that's required for setfiles.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_3xo8AaumR6y0r4x
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- /usr/src/se/policy/domains/program/setfiles.te	2004-06-17 15:10:38.000000000 +1000
+++ domains/program/setfiles.te	2004-07-12 23:04:16.000000000 +1000
@@ -37,7 +37,7 @@
 r_dir_file(setfiles_t, { policy_src_t policy_config_t file_context_t selinux_config_t })
 
 allow setfiles_t file_type:dir r_dir_perms;
-allow setfiles_t { file_type unlabeled_t }:dir_file_class_set { getattr relabelfrom };
+allow setfiles_t { file_type unlabeled_t device_type }:dir_file_class_set { getattr relabelfrom };
 allow setfiles_t file_type:{ dir file lnk_file sock_file fifo_file } relabelto;
 allow setfiles_t unlabeled_t:dir read;
 allow setfiles_t device_type:{ chr_file blk_file } relabelto;

--Boundary-00=_3xo8AaumR6y0r4x--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
