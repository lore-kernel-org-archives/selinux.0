Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA12669
	for <selinux@tycho.nsa.gov>; Thu, 22 Aug 2002 17:29:39 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA10391
	for <selinux@tycho.nsa.gov>; Thu, 22 Aug 2002 21:28:33 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id VAA10387
	for <selinux@tycho.nsa.gov>; Thu, 22 Aug 2002 21:28:30 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>, "M. H." <metalhead00@hotmail.com>
Subject: Re: restrict access by user identity
Date: Thu, 22 Aug 2002 23:28:51 +0200
Cc: <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0208221358250.29931-100000@raven> <20020822205144.E6FAA6B15@lyta.coker.com.au>
In-Reply-To: <20020822205144.E6FAA6B15@lyta.coker.com.au>
MIME-Version: 1.0
Message-Id: <20020822212851.EE0308932@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 22 Aug 2002 22:51, Russell Coker wrote:
> Any time you see a reference to user_t or user_home_t in a .te file then
> the .te file is buggy and will cause you problems with multiple user roles
> (IE you'll have to re-write that .te file).  I've just done a grep of my
> policy tree, it looks like I've got some work to do in this regard.  :(

I've just started work on the changes needed to address these issues.

I've added the following to attrib.te:
# The user_tmpfile attribute identifies all types associated with temporary
# files for unpriv_userdomain domains.
attribute user_tmpfile;

# for the user_xserver_tmp_t etc
attribute xserver_tmpfile;

Now I'm stuck on what to do with the following from file_contexts/types.fc:
/tmp/orbit.*        system_u:object_r:user_tmp_t
/tmp/.ICE-unix(|/.*)     system_u:object_r:user_tmp_t

As I don't have /tmp/orbit.* and I don't know what the .ICE-unix on my system 
is for I'm not sure what to do with them.

I plan to setup a machine in a virtual-multihead situation (different X 
servers on different virtual consoles), login under two different roles and 
shake down some of these issues.  However it'll require a spare day when I 
have no other plans for one of my headed machines.  So it may be some time 
before I get to it.

Also it appears that login.te only needs the following access to user home 
directories in my policy tree:
allow local_login_t home_dir_type:dir search;
allow remote_login_t home_dir_type:dir search;

Or the following for the policy tree from the last NSA release:
allow local_login_t home_type:dir search;
allow remote_login_t home_type:dir search;

Of course login is a "trusted" application so restricting it doesn't really 
gain us much, but there's no harm in it.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
