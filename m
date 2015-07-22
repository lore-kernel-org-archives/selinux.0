Message-ID: <55AFAAD5.80108@tycho.nsa.gov>
Date: Wed, 22 Jul 2015 10:38:13 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Jason Zaman <jason@perfinion.com>
Subject: Re: [GIT PULL] policycoreutils: fix PEP8 issues
References: <20150717142834.GA20679@meriadoc.Home>
 <55AF977C.9020705@tycho.nsa.gov>
 <20150722143111.GA20676@meriadoc.perfinion.com>
In-Reply-To: <20150722143111.GA20676@meriadoc.perfinion.com>
Content-Type: text/plain; charset=windows-1252
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/22/2015 10:31 AM, Jason Zaman wrote:
> On Wed, Jul 22, 2015 at 09:15:40AM -0400, Stephen Smalley wrote:
>> On 07/17/2015 10:28 AM, Jason Zaman wrote:
>>> Commit message:
>>>
>>>     policycoreutils: Fix PEP8 issues
>>>
>>>     When trying to get policycoreutils working in python3, I kept running
>>>     into TabErrors:
>>>
>>>         Traceback (most recent call last):
>>>           File "/usr/lib/python-exec/python3.3/semanage", line 27, in <module>
>>>             import seobject
>>>           File "/usr/lib64/python3.3/site-packages/seobject.py", line 154
>>>             context = "%s%s" % (filler, raw)
>>>                                            ^
>>>         TabError: inconsistent use of tabs and spaces in indentation
>>>
>>>     Python3 is a lot stricter than python2 regarding whitespace and looks like
>>>     previous commits mixed the two.  When fixing this, I took the chance to fix
>>>     other PEP8 style issues at the same time.
>>>
>>>     This commit was made using:
>>>     $ file $(find . -type f) | grep -i python > pyfiles
>>>     $ autopep8 --in-place --ignore=E501,E265 $(cat pyfiles)
>>>
>>>     The ignore E501 is long lines since there are many that would be wrapped
>>>     otherwise, and E265 is block comments that start with ## instead of just #.
>>
>> If this was generated entirely via autopep8, I'd prefer to take this
>> other patch series first:
>> http://marc.info/?l=selinux&m=143743932419386&w=2
>> as it will be easier to redo the autopep8 on top than the other way around.
> 
> Yes it was 100% automated, I can re-generate it now that those have been
> applied or I can wait till a bit later once the semanage.py fixes are in
> or you could just run it yourself and commit it. which would you prefer?
> 
> The important part will be to make sure that all commits afterwards are
> also following pep8.

I'll ask if Red Hat has any other patches they care to submit for
policycoreutils python code before performing the conversion.
