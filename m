Message-ID: <4AE9EF73.4090209@tycho.nsa.gov>
Date: Thu, 29 Oct 2009 15:39:31 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux List <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        Caleb Case <ccase@tresys.com>, srivasta@golden-gryphon.com,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH -v2] pkgconfig support for libsepol, libselinux, and libsemanage
References: <4ADE735D.9020901@tycho.nsa.gov>	 <1256127809.4061.170.camel@moss-pluto.epoch.ncsc.mil> <1256128292.4061.174.camel@moss-pluto.epoch.ncsc.mil> <4AE0A8B7.7070009@tycho.nsa.gov>
In-Reply-To: <4AE0A8B7.7070009@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/22/2009 02:47 PM, Eamon Walsh wrote:
> Add pkgconfig files for libsepol, libselinux, and libsemanage.
>
> Having a pkgconfig file allows the pkg-config tool to be used to
> query the presence of the library (or a particular version of it),
> and to obtain the C flags and linker arguments to build with it.
>
> Based on Debian patches by Manoj Srivastava <srivasta@debian.org>.
>
> -v2: Corrected URL, fixed requirements for libselinux and libsemanage.
>
>
> Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
> ---
>
>   

I have pushed this and bumped the library versions.  This will impact
downstreams with pkgconfig files patched in themselves.  If anything's
seriously amiss let me know.


-- 

Eamon Walsh 
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
