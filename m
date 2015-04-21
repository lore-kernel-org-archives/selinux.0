Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3LCpTAQ029724
 for <selinux@tycho.nsa.gov>; Tue, 21 Apr 2015 08:51:29 -0400
Message-ID: <553647CF.6040900@tresys.com>
Date: Tue, 21 Apr 2015 08:51:27 -0400
From: Steve Lawrence <slawrence@tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: Petr Lautrbach <plautrba@redhat.com>, <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] libselinux: selinux.py - use os.walk() instead of
 os.path.walk()
References: <1429616809-5417-1-git-send-email-plautrba@redhat.com>
 <55364103.30004@tresys.com> <553646FC.9050304@redhat.com>
In-Reply-To: <553646FC.9050304@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/21/2015 08:47 AM, Petr Lautrbach wrote:
> On 04/21/2015 02:22 PM, Steve Lawrence wrote:
>> On 04/21/2015 07:46 AM, Petr Lautrbach wrote:
>>> From: Miro Hrončok <mhroncok@redhat.com>
>>>
>>> os.path.walk() function is deprecated and has been removed in Python 3
>>>
>>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>>
>> Acked-by: Steve Lawrence <slawrence@tresys.com>
>>
>> Thanks!
> 
> Might it be that you've accidentally edited a wrong ChangeLog?
> 
> Update libselinux ChangeLog
> 

Yep. Thanks. That's been fixed.

- Steve

> --- a/libsemanage/ChangeLog
> +++ b/libsemanage/ChangeLog
> @@ -1,3 +1,5 @@
> +       * Use os.walk() instead of the deprecated os.path.walk(), from Petr
> +         Lautrbach & Miro Hrončok
> 
> 
> 
> Petr
> 
>>
>>> ---
>>>
>>> A simple fix which allows to use same construction in Python 2 and Python 3.
>>> It's reported and proposed in https://bugzilla.redhat.com/show_bug.cgi?id=1195004
>>>
>>>
>>>  libselinux/src/selinuxswig_python.i | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/libselinux/src/selinuxswig_python.i b/libselinux/src/selinuxswig_python.i
>>> index ae72246..c9a2341 100644
>>> --- a/libselinux/src/selinuxswig_python.i
>>> +++ b/libselinux/src/selinuxswig_python.i
>>> @@ -31,9 +31,9 @@ def restorecon(path, recursive=False):
>>>              lsetfilecon(path, context)
>>>  
>>>          if recursive:
>>> -            os.path.walk(path, lambda arg, dirname, fnames:
>>> -                             map(restorecon, [os.path.join(dirname, fname)
>>> -                                              for fname in fnames]), None)
>>> +            for root, dirs, files in os.walk(path):
>>> +                for name in files + dirs:
>>> +                   restorecon(os.path.join(root, name))
>>>  
>>>  def chcon(path, context, recursive=False):
>>>      """ Set the SELinux context on a given path """
>>>
>>
> 
> 
