Message-ID: <1340724362.29157.47.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: strange labelling error
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
Date: Tue, 26 Jun 2012 11:26:02 -0400
In-Reply-To: <201206270101.42198.russell@coker.com.au>
References: <201206270101.42198.russell@coker.com.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-06-27 at 01:01 +1000, Russell Coker wrote:
> I was relabelling one of my systems that I've been using for development and 
> saw the below messages.  I've got no idea how "SystemLow" apparently got into 
> the contexts of lots of files.  Any ideas?

A domain with :capability2 mac_admin permission could set any arbitrary
value as a file security context, so it would just require a program in
such a domain (or perhaps any root program in permissive mode) to
accidentally pass the translated security context to setxattr or
possibly even to setfilecon if mcstrans wasn't running.

> I can't reproduce it so I'm not particularly worried, presumably later 
> versions of the code in question fixed it.  Given the files that were affected 
> I suspect a bug in dpkg or in the SE Linux libraries it uses.  But it's a 
> fairly strange one.
> 
> restorecon reset /usr/share/doc/xserver-xorg-video-intel/changelog.gz context 
> system_u:object_r:usr_t:SystemLow->system_u:object_r:usr_t:s0
> restorecon reset /usr/share/doc/xserver-xorg-video-intel/NEWS.gz context 
> system_u:object_r:usr_t:SystemLow->system_u:object_r:usr_t:s0
> restorecon reset /usr/share/doc/xserver-xorg-video-intel/README.Debian context 
> system_u:object_r:usr_t:SystemLow->system_u:object_r:usr_t:s0
> restorecon reset /usr/share/doc/xserver-xorg-video-intel/changelog.Debian.gz 
> context system_u:object_r:usr_t:SystemLow->system_u:object_r:usr_t:s0
> restorecon reset /usr/share/doc/xserver-xorg-video-intel/README context 
> system_u:object_r:usr_t:SystemLow->system_u:object_r:usr_t:s0
> restorecon reset /usr/share/doc/xserver-xorg-video-intel/copyright context 
> system_u:object_r:usr_t:SystemLow->system_u:object_r:usr_t:s0
> 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
