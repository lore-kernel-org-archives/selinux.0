Message-ID: <4ADE74F2.8000504@tycho.nsa.gov>
Date: Tue, 20 Oct 2009 22:41:54 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>, Caleb Case <ccase@tresys.com>,
        srivasta@golden-gryphon.com, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH] pkgconfig support for libsepol, libselinux, and libsemanage
References: <4ADE735D.9020901@tycho.nsa.gov>
In-Reply-To: <4ADE735D.9020901@tycho.nsa.gov>
Content-Type: multipart/mixed;
 boundary="------------010302040403070402070306"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010302040403070402070306
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/2009 10:35 PM, Eamon Walsh wrote:
> Add pkgconfig files for libsepol, libselinux, and libsemanage.
>
> Having a pkgconfig file allows the pkg-config(1) tool to be used to
> query the presence of the library (or a particular version of it),
> and to obtain the C flags and linker arguments required to use it.
>
> Based on Debian patches by Manoj Srivastava<srivasta@debian.org>.
>
> Signed-off-by: Eamon Walsh<ewalsh@tycho.nsa.gov>
> ---
>
> Note that the .pc.in files themselves could use some review to make
> sure the Requires and Libs lines are correct.  The sepol and selinux
> ones are from the Debian repos; the semanage one I wrote myself.
>
>    

Re-send with non-mangled patch (attached).

-- 
Eamon Walsh<ewalsh@tycho.nsa.gov>
National Security Agency


--------------010302040403070402070306
Content-Type: text/x-patch;
 name="0001-Add-pkgconfig-files-for-libsepol-libselinux-and-libs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Add-pkgconfig-files-for-libsepol-libselinux-and-libs.pa";
 filename*1="tch"


--------------010302040403070402070306--
