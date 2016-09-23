Subject: Re: setools4 support
To: Jason Zaman <jason@perfinion.com>
References: <1474557453-14379-1-git-send-email-jason@perfinion.com>
 <dab0152e-1976-5eab-b834-6c1b572ff4bc@tycho.nsa.gov>
 <20160923174733.GB1499@meriadoc>
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>,
 Petr Lautrbach <plautrba@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <04b9e132-d3ab-c311-708d-9309cd4c180d@tycho.nsa.gov>
Date: Fri, 23 Sep 2016 14:15:19 -0400
MIME-Version: 1.0
In-Reply-To: <20160923174733.GB1499@meriadoc>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/23/2016 01:47 PM, Jason Zaman wrote:
> On Fri, Sep 23, 2016 at 01:07:15PM -0400, Stephen Smalley wrote:
>> On 09/22/2016 11:17 AM, Jason Zaman wrote:
>>> Hi all,
>>>
>>> I finally got everything updated to use setools4. The most complicated parts
>>> were sepolicy.search() and sepolicy.info() which were largely undocumented. I
>>> dumped and diff'd the output from the old and new code so am fairly confident
>>> that they are the same (barring some issues that setools3 appears to have with
>>> cil). I also changed several places to just use setools directly, having the
>>> indirection through search() mostly just complicates and slows things down.
>>>
>>> The first patch is just cleanup. Next imports and initializes setools.
>>> Patches 3-4 update a lot of the users of search() and info() to work with the next
>>> changes.
>>> Patches 5-6 update search() and info() themselves and the last drops the C
>>> module completely
>>>
>>> I dont know the status of setools4 on fedora (someone else will have to update
>>> the README if needed) or others but I've added it masked in gentoo a fair while
>>> ago. Once this patchset is merged we can finally get rid of setools3, its been
>>> half-broken for a while now.
>>
>> AFAICT, setools4 is not packaged for Fedora yet.
>> $ git clone https://github.com/TresysTechnology/setools
>> $ cd setools
>> $ git checkout 4.0
> $ python setup.py build_ext
> 
> Try that to build the C module first before installing

Thanks, that yielded a working sesearch at least.  Unfortunately, I now
get this with sepolicy with your patches applied, unless I am somehow
still running the old version:
$ sepolicy
Traceback (most recent call last):
  File "/usr/bin/sepolicy", line 27, in <module>
    import sepolicy
  File "/usr/lib64/python2.7/site-packages/sepolicy/__init__.py", line
7, in <module>
    from . import _policy
ImportError: libapol.so.4: cannot open shared object file: No such file
or directory

This is after doing:
$ sudo make LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install install-pywrap relabel
in selinux with your patches applied.
