Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l258AaTu032339
	for <selinux@tycho.nsa.gov>; Mon, 5 Mar 2007 03:10:36 -0500
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l258Buce017935
	for <selinux@tycho.nsa.gov>; Mon, 5 Mar 2007 08:11:57 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Subject: Re: Changes to apt policy
Date: Mon, 5 Mar 2007 08:58:28 +1100
Cc: SELinux List <selinux@tycho.nsa.gov>
References: <44406275-10D4-4C48-A050-D8ECA4127216@sf-net.com>
In-Reply-To: <44406275-10D4-4C48-A050-D8ECA4127216@sf-net.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200703050858.29982.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 04 March 2007 10:08, Stefan Schulze Frielinghaus <stefan@sf-net.com> 
wrote:
> to get aptitude working quite nice a logfile and a lockfile have to
> be created. The patches attached should allow this. Also aptitude
> writes to the home directory $HOME/.aptitude where configfiles etc.
> are in. I tried to learn from the gpg and screen policy files how to
> handle such a situation (per_role_template) but please look at it and
> correct any mistakes ;-)

The apt.te patch seems OK.

Regarding apt.if and apt.fc, why would you want to run apt in a role other 
than sysadm_r for serious use?

Obviously there's "apt-get source" which can be run as any user - this can be 
enabled by making the data that apt-get needs for such operations readable by 
the users in question (I think it's almost always OK to have such data 
world-readable as it's generally just a mirror of web sites).  Therefore for 
the "apt-get source" operation (the only apt operation performed by a 
non-sysadm_r user) apt does not need any special domain or any special 
labelling for files it creates.

For the serious operations (installing packages etc) any role which has such 
access will have the ability to take over the system (Debian packages have 
lots of questions in postinst that should only be answered by the sys-admin).  
This means that the user who can run apt in such a manner should be granted 
the sysadm_r role.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
