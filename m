Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1HBI255007579
	for <selinux@tycho.nsa.gov>; Sun, 17 Feb 2008 06:18:02 -0500
Received: from nospam.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1HBHxQu010816
	for <selinux@tycho.nsa.gov>; Sun, 17 Feb 2008 11:18:00 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: secadm/sysadm discussion
Date: Sun, 17 Feb 2008 22:17:55 +1100
Cc: selinux <selinux@tycho.nsa.gov>
References: <1203030583.3669.197.camel@bluejay.goodinassociates.com> <1203093415.3669.258.camel@bluejay.goodinassociates.com> <47B60285.9010801@redhat.com>
In-Reply-To: <47B60285.9010801@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802172217.56506.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 16 February 2008 08:22, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Personally I think sysadm_t is a waste of time.  It is a poor mans
> unconfined_t and should be eliminated from the face of the earth.

I agree.

For those who aren't aware of the history sysadm_t predates unconfined_t by 
years and was used for things for which unconfined_t is now used.

There is also a conceptual difference, as indicated by the name sysadm_t was 
for system administration not regular user sessions.  Many of the problems 
with user_t which drove the development of the Targeted policy would not have 
occurred if sysadm_t had been used for all users (although even if that had 
been done there was still need for unconfined_t at that time).

> All 
> it does is generate Bugs and avc messages without supplying any real
> security.  It makes no sense, as a confinement of a root user since it
> is so easily gotten around.

Also the sysadm_t vs secadm_t distinction is even worse in some ways.

> Fedora 9 will have the ability to easily design an confined admin role.
>  I have added NAME_admin interfaces to every confined service domain,
> and system-config-selinux/polgengui now has the ability to select the
> NAME_admin domains that you want to administer.  I believe this is the
> way to confine a root user.  You can than setup a confined login user
> staff_t or guest_t and define transitions from this domain to the admin
> domain.  sudo can now be used to handle the transition.

Good work.  I had experimented with such things in the past, but policy now 
supports them in a better manner (without getting the macro hell).

> I think we will find lots of bugs in this method, but we need people to
> experiment with it.  I think we will also find security vulnerabilities
> which we will need to fix in the kernel.  (chmod 4755 shell) for example.

While I agree with the general concept, chmod 4755 shell doesn't do what you 
imagine for the common shells (at least the shells I tested last time I saw 
this issue on a mailing list).  Similar chcon commands will however allow you 
to do interesting things.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
