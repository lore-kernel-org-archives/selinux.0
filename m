Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w159nTqJ002838
 for <selinux@tycho.nsa.gov>; Mon, 5 Feb 2018 04:49:29 -0500
Received: from mail-lf0-f53.google.com (mail-lf0-f53.google.com
 [209.85.215.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 1502156123A
 for <selinux@tycho.nsa.gov>; Mon,  5 Feb 2018 10:48:38 +0100 (CET)
Received: by mail-lf0-f53.google.com with SMTP id g72so40769304lfg.5
 for <selinux@tycho.nsa.gov>; Mon, 05 Feb 2018 01:48:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180202102153.GA28019@pl-rpi.tpb.lab.eng.brq.redhat.com>
References: <SELinuxProject/selinux/pull/77@github.com>
 <20180202102153.GA28019@pl-rpi.tpb.lab.eng.brq.redhat.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Mon, 5 Feb 2018 10:48:36 +0100
Message-ID: <CAJfZ7==c+Nn2pKu6QiZqxhVFg14MaU4Z3aGJz5bMOXgVK9PHzQ@mail.gmail.com>
To: Petr Lautrbach <plautrba@redhat.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [SELinuxProject/selinux] gui: remove
 selinux-sepolgengui (#77)
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Feb 2, 2018 at 11:21 AM, Petr Lautrbach <plautrba@redhat.com> wrote:
> On Thu, Jan 25, 2018 at 01:58:46PM -0800, Nicolas Iooss wrote:
>> Hi,
>> I sent a few hours ago these two patches on the mailing list, by as the first one seems to be blocked somewhere (I have only received back the second one), I am publishing them on Github too, as a Pull Request.
>>
>> These patches removes selinux-sepolgengui because this application is not compatible with Gtk3, Python 3 (it requires PyGTK), etc. and would otherwise require some effort to update it.
>> More precisely, even though ``pygi-convert.sh`` updated the code in order to try making the application compatible with Python 3, PyGI... (in commit 0f3beeb00e7a42cc2f44ef0392b8a3a7566a17d7), ``polgen.glade`` is still incompatible with Gtk-Builder (it would need to be converted). I do not want to spend time converting this file when I see that a bug preventing this application to launch has been present for more than one year.
>
>
>> polgengui.py is not compatible with Gtk3, Python 3, etc. Moreover it
>> fails to load at least since the release 2.6-rc1:
>>
>> $ python2 /usr/share/system-config-selinux/polgengui.py
>> Traceback (most recent call last):
>>   File "/usr/share/system-config-selinux/polgengui.py", line 778, in <module>
>>     app = childWindow()
>>   File "/usr/share/system-config-selinux/polgengui.py", line 205, in __init__
>>     self.all_types = sepolicy.generate.get_all_types()
>> AttributeError: 'module' object has no attribute 'generate'
>
> This particular problem was fixed in Fedora by
> https://github.com/fedora-selinux/selinux/commit/ecd050d12cde54f3d7a31029be8582223d3d6eba
>
> I must have forgotten to re-send it. Sorry.
>
>> In fact, this bug has been introduced more than a year ago by commit
>> b43991f ("policycoreutils: import sepolicy directly"), which
>> replaced "from sepolicy import generate" with "import sepolicy" instead
>> of "import sepolicy.generate".
>>
>> As no one seems to have noticed, this application seems to be no longer
>> used. Remove it from gui/.
>
>
> I'd like to ask to postpone accepting this patch for another 2
> weeks. I'll try to port/convert polgengui.py to be compatible with
> Gtk-Builder. I'll come back either with patch or with Ack to drop it.
>
> Thanks,
>
> Petr

Sure, I agree with this plan. I will wait to hear back from you before
merging or dropping the patches I posted.

Thanks,
Nicolas
