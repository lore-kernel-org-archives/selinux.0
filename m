Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA05741
	for <selinux@tycho.nsa.gov>; Thu, 7 Mar 2002 07:03:23 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA18772
	for <selinux@tycho.nsa.gov>; Thu, 7 Mar 2002 12:02:23 GMT
Received: from angusbay.vnl.com ([194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id MAA18768 for <selinux@tycho.nsa.gov>; Thu, 7 Mar 2002 12:02:22 GMT
Date: Thu, 7 Mar 2002 12:14:32 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Stephen Smalley <sds@tislabs.com>, SE Linux <selinux@tycho.nsa.gov>,
        miquels@cistron.nl
Subject: Re: Squid policy for SE Linux
Message-ID: <20020307121431.GF13355@vnl.com>
References: <Pine.GSO.4.33.0203061158000.24985-100000@raven> <20020306200023.32F211F08B@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020306200023.32F211F08B@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Mar 06, 2002 at 09:00:22PM +0100, Russell Coker wrote:

> > >allow squid_t squid_exec_t:file execute_no_trans;
> >
> > I'm not clear as to why this is needed, unless squid re-executes itself at
> > times.
> 
> It appears to do that.  I'm not sure why, maybe Mike can shed some light.

I know squid has multiple instances of itself, and
you often have perl scripts attached as filters. I've
often used this for systems that need to capture the
first web access attempt and replace it with a portal
page. 

I think those instances are started as required, but
it's been about 2 years since I worked on this.

-- 
------------------------------------------------------
    Nuke bin Laden:           Dale Amon, CEO/MD
  improve the global          Islandone Society
     gene pool.               www.islandone.org
------------------------------------------------------

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
