Subject: Re: [PATCH -v2] policycoreutils: get setfiles to skip mounts
 without seclabel
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Thomas Liu <tliu@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov,
        jmorris@namei.org, eparis@parisplace.org
In-Reply-To: <1247842112.2096.0.camel@Ares>
References: <1247580944.2266.1.camel@Ares>
	 <1247585401.28321.336.camel@moss-pluto.epoch.ncsc.mil>
	 <1247587468.2164.17.camel@Ares>  <4A5CC564.3090408@redhat.com>
	 <1247842112.2096.0.camel@Ares>
Content-Type: text/plain
Date: Fri, 24 Jul 2009 16:12:14 -0400
Message-Id: <1248466334.3465.15.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-07-17 at 10:48 -0400, Thomas Liu wrote:
> Get setfiles to check paths for seclabel and skip them
> if it is not supported.
> 
> Parse /proc/mounts and add paths that do not have seclabel
> to the exclude list.  If another path shows up that does
> have seclabel, remove it from the exclude list, since setfiles
> will try and when it fails it will skip it.
> 
> Also made one of the error messages in add_exclude more
> descriptive.
> 
> Signed-off-by: Thomas Liu <tliu@redhat.com>
> Signed-off-by: Dan Walsh <dwalsh@redhat.com>
> ---

Thanks, merged in policycoreutils 2.0.68.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
