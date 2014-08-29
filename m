Message-ID: <5400987A.7000406@tycho.nsa.gov>
Date: Fri, 29 Aug 2014 11:12:58 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Paul Moore <pmoore@redhat.com>
Subject: Re: [PATCH] file: replace 'ls -Z' with 'ls -lZ' for consistent results
References: <20140828204738.10801.34505.stgit@localhost>
 <54006D79.1050409@tycho.nsa.gov> <5782178.DNEPL1ls2l@sifl>
In-Reply-To: <5782178.DNEPL1ls2l@sifl>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Serge Hallyn <serge.hallyn@ubuntu.com>, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/29/2014 10:37 AM, Paul Moore wrote:
> On Friday, August 29, 2014 08:09:29 AM Stephen Smalley wrote:
>> On 08/28/2014 04:47 PM, Paul Moore wrote:
>>> I'm not sure the exact date of the change, but 'ls -Z' on Rawhide is
>>>
>>> a bit different than in the past; the output now looks like this:
>>>   # /bin/ls -Z test
>>>   system_u:object_r:test_file_t:s0 test
>>
>> That seems very wrong - who knows how many userspace scripts may rely on
>> the output of ls -Z having a given format?   Is this a change in
>> upstream coreutils or Fedora-specific?
> 
> It does seems a bit odd to me too, but I'm in need of a quick solution and 
> changing to using the '-l' flag served that purpose.  I can try to track down 
> the source of the change, but it probably isn't going to happen today.
> 
> In the meantime, using '-l' doesn't hurt anything, and it works.

...on rawhide, maybe.  It breaks the test on Fedora 20, and presumably
on every older Fedora and RHEL release.
