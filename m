Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v8JKml2m029059
 for <selinux@tycho.nsa.gov>; Tue, 19 Sep 2017 16:48:50 -0400
Received: from mail-lf0-f44.google.com (mail-lf0-f44.google.com
 [209.85.215.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id E3453564830
 for <selinux@tycho.nsa.gov>; Tue, 19 Sep 2017 22:34:04 +0200 (CEST)
Received: by mail-lf0-f44.google.com with SMTP id l196so807234lfl.1
 for <selinux@tycho.nsa.gov>; Tue, 19 Sep 2017 13:34:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFftDdpK76tNwLjBJjpBC9WHHbdpTKqHDt33RZ5xW37jFmD-6g@mail.gmail.com>
References: <20170918213213.23160-1-nicolas.iooss@m4x.org>
 <CAFftDdoyogjzdoO8=EPBTFNHp6LKSOzT0wwfGVoBZdr5qwS+Qw@mail.gmail.com>
 <CAFftDdpK76tNwLjBJjpBC9WHHbdpTKqHDt33RZ5xW37jFmD-6g@mail.gmail.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Tue, 19 Sep 2017 22:34:03 +0200
Message-ID: <CAJfZ7=kBtG=vPd0Tgvtv_-9BgoPapT9-2m0ufz=XgXhvT1d-JQ@mail.gmail.com>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 1/1] sepolicy: do not fail when
 file_contexts.local or .subs do not exist
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Sep 19, 2017 at 1:01 AM, William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Mon, Sep 18, 2017 at 3:59 PM, William Roberts
> <bill.c.roberts@gmail.com> wrote:
>> On Mon, Sep 18, 2017 at 2:32 PM, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>>>
>>> On a system without any file context customizations, "sepolicy gui"
>>> fails to load because it tries to read a non-existent file:
>>>
>>>     FileNotFoundError: [Errno 2] No such file or directory:
>>>     '/etc/selinux/refpolicy-git/contexts/files/file_contexts.local'
>>>
>>> Once this issue is fixed, another one is triggered:
>>>
>>>     FileNotFoundError: [Errno 2] No such file or directory:
>>>     '/etc/selinux/refpolicy-git/contexts/files/file_contexts.subs
>>>
>>> Use os.path.exists() to prevent trying to open non-existent files.
>>>
>>> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>>> ---
>>>  python/sepolicy/sepolicy/__init__.py | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
>>> index 03742346caf0..14d2ad634d7d 100644
>>> --- a/python/sepolicy/sepolicy/__init__.py
>>> +++ b/python/sepolicy/sepolicy/__init__.py
>>> @@ -523,6 +523,8 @@ def find_entrypoint_path(exe, exclude_list=[]):
>>>
>>>
>>>  def read_file_equiv(edict, fc_path, modify):
>>> +    if not os.path.exists(fc_path):
>>> +        return edict
>>>      fd = open(fc_path, "r")
>>>      fc = fd.readlines()
>>>      fd.close()
>>> @@ -555,6 +557,8 @@ def get_local_file_paths(fc_path=selinux.selinux_file_context_path()):
>>>      if local_files:
>>>          return local_files
>>>      local_files = []
>>> +    if not os.path.exists(fc_path + ".local"):
>>> +        return []
>>>      fd = open(fc_path + ".local", "r")
>>
>> Why not use Try/Except here with a pass here?
>
> Wouldn't be a pass... but you get the idea.

It modifies more lines, but as you suggested it I will send a v2 which
uses try/except. In order to keep the code compatible with Python 2,
it will be "except OSError" + errno checking to silently skip
non-existing file.
>
>> While you're at it, maybe update this to use a with
>> statement. instead of an explicit close call.
>>>      fc = fd.readlines()
>>>      fd.close()

I will do it. Thanks for you suggestions.

Nicolas
