Message-ID: <1347975644.29192.15.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: clean up in android.c
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Tue, 18 Sep 2012 09:40:44 -0400
In-Reply-To: <CAFftDdrK8sR=HuHxryryzDjfFOSz_GBsLusPrdsGqXe79YVsYA@mail.gmail.com>
References: 
	<CAFftDdrK8sR=HuHxryryzDjfFOSz_GBsLusPrdsGqXe79YVsYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-09-14 at 17:09 -0700, William Roberts wrote:
> Would anyone object to me cleaning up the setcon and setfilecon2 code
> that does the mls level stuff:
> 
> 
> Currently the below code is duplicated:
<snip>
> I want to break it up into two functions.
> 
> 
> 1. that gets the normalized username
> 2. that computes the id, takes username, returns -1 on error

> This way of the username stuff changes again in the future, we can
> normalize it one spot. The one that computes the id doesn't gain much
> by putting it in a function, but I think it will make the code more
> readable.

I think the setcon and setfilecon2 code could be further unified so that
the entire logic for matching an entry is encapsulated in a single
helper function that takes a bool argument indicating whether it is
looking for a domain or type entry.

We might also want to reconsider how we map the app usernames to a
string for seapp_contexts.  I just remapped the new format to the app_
prefix so that there would be no breakage going from ICS to JB, but it
is a bit misleading.

I also think we might want to revisit how we compute the level.
Rather than only setting a single category, we might want to compute a
category pair based on the UID to increase the number of possible unique
levels and avoid any risk that we will run out of unique levels for a
large number of installed apps.  For comparison, libvirt assigns a
randomly selected category pair for virtual machines and I heard
recently that OpenShift is mapping UIDs to category pairs.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
