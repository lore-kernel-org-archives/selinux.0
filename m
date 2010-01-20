Subject: Re: contents of /etc/selinux/<type>/contexts/users/*
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D07F915C6@de01exm68.ds.mot.com>
References: <4AF71B05.8030707@cs.purdue.edu>
	 <4B035FA4.6080605@ak.jp.nec.com> <4B056D3D.2050303@cs.purdue.edu>
	 <4B1411B5.5050406@cs.purdue.edu> <4B146B17.50706@ak.jp.nec.com>
	 <4B14934F.9050401@cs.purdue.edu>
	 <1263570719.20826.21.camel@moss-pluto.epoch.ncsc.mil>
	 <4B54339F.8070501@ak.jp.nec.com>  <4B5685D5.7040307@ak.jp.nec.com>
	 <1263994416.24133.4.camel@moss-pluto.epoch.ncsc.mil>
	 <D06FE0A2807BC145B0D38744789D4F5D07F915C6@de01exm68.ds.mot.com>
Content-Type: text/plain
Date: Wed, 20 Jan 2010 12:33:04 -0500
Message-Id: <1264008784.24133.115.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-01-20 at 11:29 -0500, Hasan Rezaul-CHR010 wrote:
> Hi All,
> 
> Can you please point me to documentation that describes the syntax
> details of the files found in the directory:
> 
> /etc/selinux/<type>/contexts/users/
>                                    local.users
>                                    root
>                                    staff_u
>                                    system.users
>                                    unconfined_u
>                                    user_u
> 
> These files are already created for me, with several lines in them. I
> would like to better understand what the content of these files really
> mean and what its really doing... This way, I could perhaps make some
> adjustments to customize them for my specific needs. Thanks in advance.

These are just per-user versions of the default_contexts file, see:
http://www.nsa.gov/research/_files/selinux/papers/policy2/x724.shtml

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
