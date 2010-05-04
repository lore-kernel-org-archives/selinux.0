Subject: Re: I am trying to build an MLS livecd.
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>,
        James Morris <jmorris@redhat.com>
In-Reply-To: <1273005899.30175.195.camel@moss-pluto.epoch.ncsc.mil>
References: <4BE04C8A.7070907@redhat.com>
	 <1272991523.30175.142.camel@moss-pluto.epoch.ncsc.mil>
	 <4BE064F2.3060505@redhat.com>
	 <1272998789.30175.170.camel@moss-pluto.epoch.ncsc.mil>
	 <4BE06DED.4070801@redhat.com>
	 <1273001899.30175.190.camel@moss-pluto.epoch.ncsc.mil>
	 <1273005563.15368.21.camel@localhost>
	 <1273005899.30175.195.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 04 May 2010 16:57:04 -0400
Message-ID: <1273006624.15368.26.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-05-04 at 16:44 -0400, Stephen Smalley wrote:
> On Tue, 2010-05-04 at 16:39 -0400, Eric Paris wrote:

> > # file: home/liveuser
> > security.selinux="privuser_u:object_r:user_home_dir_t:s0-s15:c0.c1023
> 
> So that looks correct.  What was the problem again?

Obviously I can't reproduce, I managed to boot my minimal live disk
inside a vm and I'm seeing the right thing.  So I blame Dan's setup.
I'm running most up2date F13 with F14 kernels....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
