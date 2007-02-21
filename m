From: Stefanos Harhalakis <v13@it.teithe.gr>
To: Steve G <linux_4ever@yahoo.com>
Subject: Re: libselinux patch
Date: Wed, 21 Feb 2007 16:47:46 +0200
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
References: <20070221133743.85727.qmail@web51506.mail.yahoo.com>
In-Reply-To: <20070221133743.85727.qmail@web51506.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Message-Id: <200702211647.46457.v13@it.teithe.gr>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 21 February 2007 15:37, Steve G wrote:
> >At present, libselinux dynamically determines where selinuxfs is mounted
> >via /proc/mounts in init_selinuxmnt() and uses that path for all calls
> >that operate on selinuxfs.
>
> I guess that path could be used for statfs?
>
> >Also, statfs'ing /selinux requires selinuxfs to already be mounted before
> >you can call is_selinux_enabled(),
>
> Is selinux really enabled if its not available for use (mounted)?

  When working under chroot(), /proc may be available but /selinux may not be. 
In that case /proc/mounts will list /selinux but you will not be able to 
stat() it.

<<V13>>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
