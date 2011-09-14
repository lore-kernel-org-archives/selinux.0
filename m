Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8EJVx3s029261
	for <selinux@tycho.nsa.gov>; Wed, 14 Sep 2011 15:31:59 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p8EJVvg9028396
	for <selinux@tycho.nsa.gov>; Wed, 14 Sep 2011 19:31:58 GMT
Subject: Re: [PATCH] Fix function arguments in libsemanage tests (was Re:
 [PATCH v4] Fix includes for userspace tools and libraries)
From: Eric Paris <eparis@redhat.com>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>,
        Eric Paris
	 <eparis@parisplace.org>
Date: Wed, 14 Sep 2011 15:31:50 -0400
In-Reply-To: <1315956807.2218.98.camel@vortex>
References: <1315587716.2170.16.camel@vortex>
	 <1315588656.2170.26.camel@vortex>
	 <CACLa4pu2eN1OM_ni5Zssb8O9d0S49CoAZnS4-XKoALNdqunCsA@mail.gmail.com>
	 <1315832253.17035.5.camel@moss-pluto> <1315859373.2223.19.camel@vortex>
	 <4E6E8149.30702@redhat.com> <1315917697.12522.1.camel@moss-pluto>
	 <1315931495.2248.29.camel@vortex> <1315934421.12522.46.camel@moss-pluto>
	 <1315938784.2218.14.camel@vortex> <1315939689.12522.51.camel@moss-pluto>
	 <1315941501.2218.26.camel@vortex>  <1315941958.12522.77.camel@moss-pluto>
	 <1315942469.12522.81.camel@moss-pluto> <1315944244.2218.41.camel@vortex>
	 <1315945618.2738.13.camel@localhost> <1315951507.2218.91.camel@vortex>
	 <1315956807.2218.98.camel@vortex>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316028712.2738.34.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-09-14 at 01:33 +0200, Guido Trentalancia wrote:
> Another possible improvement could be as follows (libsemanag):
> 
> Fix a few calls to semanage_store_access_check() in the libsemanage
> tests so that a void function is called.

Please in the future include a line which looks something like the
following at the end of the comments with all patches you wish to have
committed:

Signed-off-by: Guido Trentalancia <guido@trentalancia.com>

The purpose of this line is to indicate that you have the rights to
contribute this code to the project and that you agree to license the
code according to the license(s) of the file(s) that the patch will be
applied to.

I prefer patches in the format like the linux kernel: 
https://github.com/torvalds/linux/blob/master/Documentation/SubmittingPatches

Basically that entails the subject line of the e-mail is the short
description of the patch (nothing extra except inside the [])

The body should be a complete description of what change you made and in
particular why.  You should mention testing and things like that as
well.

The signed-off-by line.
The last line of the changelog should be just --- (at the beginning of
the line)

After the --- line include the patch.

thanks so much!

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
