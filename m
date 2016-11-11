Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAB0wGpr012509
 for <selinux@tycho.nsa.gov>; Thu, 10 Nov 2016 19:58:16 -0500
Subject: Re: [Patch v2 2/2] policycoreutils: Make sepolicy work with python3
To: Stephen Smalley <sds@tycho.nsa.gov>, Laurent Bigonville
 <bigon@debian.org>, selinux@tycho.nsa.gov
References: <20161107080117.24030-2-bigon@debian.org>
 <20161107095108.22306-1-bigon@debian.org>
 <21527c6a-410d-d819-2e43-a90b2d757694@tycho.nsa.gov>
 <0218ca49-6e92-33e0-cb29-4a792c1b5b7c@tycho.nsa.gov>
From: Chris PeBenito <pebenito@ieee.org>
Message-ID: <7ce6bf50-c7e4-965f-e9df-eb5a3d4249dc@ieee.org>
Date: Thu, 10 Nov 2016 19:58:18 -0500
MIME-Version: 1.0
In-Reply-To: <0218ca49-6e92-33e0-cb29-4a792c1b5b7c@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/08/16 10:29, Stephen Smalley wrote:
> On 11/08/2016 10:21 AM, Stephen Smalley wrote:
>> On 11/07/2016 04:51 AM, Laurent Bigonville wrote:
>>> From: Laurent Bigonville <bigon@bigon.be>
>>>
>>> Add python3 support for sepolicy
>>>
>>> Signed-off-by: Laurent Bigonville <bigon@bigon.be>
>>> ---
>>>  policycoreutils/sepolicy/selinux_client.py       |  6 ++--
>>>  policycoreutils/sepolicy/sepolicy.py             | 38 ++++++++++++------------
>>>  policycoreutils/sepolicy/sepolicy/__init__.py    | 16 ++++++----
>>>  policycoreutils/sepolicy/sepolicy/communicate.py |  4 +--
>>>  policycoreutils/sepolicy/sepolicy/generate.py    | 30 +++++++++----------
>>>  policycoreutils/sepolicy/sepolicy/interface.py   | 14 ++++++---
>>>  policycoreutils/sepolicy/sepolicy/manpage.py     |  7 +++--
>>>  7 files changed, 65 insertions(+), 50 deletions(-)
>>
>> make test doesn't pass in policycoreutils/sepolicy, although I'm not
>> sure that's new to this patch.  I think the manpage ones were already
>> failing; I don't recall the network one hanging before though.  But
>> maybe that is because I wasn't testing with setools3 fully removed before?
>
> Oh, I guess it is just very slow with setools4.  It did finally complete
> sepolicy network -d and has moved on (next slow/hanging one is
> transition -t).

Yes, sadly setools4 is slower.  I haven't spent much time on trying to 
improve the performance yet (preliminary profiling seems to indicate 
that swig is the problem).  However, looking through the sepolicy code, 
I found that it could use the setools code more efficiently (I realize 
the first matter of business was just to get it over to setools4).

The biggest win will be to minimize how many times the code iterates 
over all TE rules.  For example, in the search function, it runs the 
TERuleQuery twice, when it could be done in one query.  Also, for the 
transition command, it seems to manually implement a domain transition 
analysis.  When I compared the sepolicy transition run time to sedta, 
sedta was a minute faster for the same analysis.

-- 
Chris PeBenito
