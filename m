Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6EGrkL4004212
	for <selinux@tycho.nsa.gov>; Thu, 14 Jul 2011 12:53:46 -0400
Received: from mxout-08.mxes.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p6EGrjUf027492
	for <selinux@tycho.nsa.gov>; Thu, 14 Jul 2011 16:53:45 GMT
Message-ID: <20110714175338.12159elqy4yyadxs@webmail.tuffmail.net>
Date: Thu, 14 Jul 2011 17:53:38 +0100
From: Martin Orr <martin@martinorr.name>
To: Eric Paris <eparis@parisplace.org>
Cc: russell@coker.com.au, Daniel J Walsh <dwalsh@redhat.com>,
        SE-Linux
	<selinux@tycho.nsa.gov>
Subject: Re: subs_dist and libselinux releases
References: <201107141611.41063.russell@coker.com.au>
	<CACLa4ptDbYinwwAjff8jq2XUmhxAcu2q8_yGd6sigq7byzM1hA@mail.gmail.com>
In-Reply-To: <CACLa4ptDbYinwwAjff8jq2XUmhxAcu2q8_yGd6sigq7byzM1hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu 14 Jul 10:34:18 2011, Eric Paris wrote:
> On Thu, Jul 14, 2011 at 8:11 AM, Russell Coker <russell@coker.com.au> wrote:
>> http://userspace.selinuxproject.org/trac/browser/libselinux/src?order=date&desc=1
>> http://userspace.selinuxproject.org/trac/wiki/Releases
>>
>> The patch for the subs_dist file was first proposed in April, when  
>> will there
>> be a new upstream release that includes it?
>>
>> Currently we have a need for this in Debian, but it doesn't seem  
>> that there is
>> an upstream release with it.  I would prefer to avoid maintaining  
>> my own patch
>> set for libselinux in this regard if possible.
>
> Russell et al.
>
> I've started to take on trying to catch userspace up with the latest
> and greatest based on what Fedora has done and not upstreamed and
> patches I could find on the list.  Believe me, it's a project:
>
>  78 files changed, 1616 insertions(+), 31867 deletions(-)
>
> I have commit access to the upstream repo, but at the moment I haven't
> really started reviewing patches closely enough to commit them and am
> just trying to get a tree everyone can start to review.  (And it's the
> tree I plan to make Fedora start using while I work the patches into
> the upstream tree)

The subs_dist patch Russell asks about has already been merged:
20b43b3fd3d392c4f12a963a4e46c264e7ed5163

But I am not entirely clear about the relation between upstream git  
and what is listed here:
http://userspace.selinuxproject.org/trac/wiki/Releases

-- 
Martin Orr



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
