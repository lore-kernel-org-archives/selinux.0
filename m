Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6TNFh81018787
	for <selinux@tycho.nsa.gov>; Sun, 29 Jul 2012 19:15:43 -0400
Message-ID: <5015C421.10906@manicmethod.com>
Date: Sun, 29 Jul 2012 19:15:45 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: William Roberts <bill.c.roberts@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Mirrors
References: <CAFftDdqvjCJY+EoxGN+0QcHPVTv7Gzpg8ykDaPVG2-R32TyzqA@mail.gmail.com> <50141AB2.8010407@manicmethod.com> <CAFftDdq9KyfLNXUfGmpf3ywcV01-Wthfdn-BzVb5iTochUBS-A@mail.gmail.com> <CAFftDdoJGaao4wSp-MOx3qXo4p7a0bvmdLxHys8gh-0iNA16dw@mail.gmail.com> <CAFftDdrzA1=Xg63cJUSv=LjgGq=S9pN7O2WzcG3sJdT1vviGEw@mail.gmail.com>
In-Reply-To: <CAFftDdrzA1=Xg63cJUSv=LjgGq=S9pN7O2WzcG3sJdT1vviGEw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It is working here:

$ repo sync -j8
Fetching projects: 100% (386/386), done.

William Roberts wrote:
> It looks like repo and tuna are not getting along, with the only thing
> in the local_manifest.xml file is tuna:
>
> git@sta105992:/repo/seandroid$ repo sync -j8
> remote: Counting objects: 5870, done.
> remote: Compressing objects: 100% (3180/3180), done.
> Receiving objects:  95% (5610/5870), 1023.46 MiB | 311 KiB/s
> 1/5870), 17.44 MiB | 715 KiB/s
>
> It is not over a gig....
>
> On Sat, Jul 28, 2012 at 3:08 PM, William Roberts
> <bill.c.roberts@gmail.com>  wrote:
>> I even tried with -j1 to make sure it wasn't a deadlock in git or the
>> repo tool and it still would hang. It seems syncing one by one from
>> the local manifest (even with a high -j option) works fine. Once the
>> initial mirror sync for master works, ill try it with a full local
>> manifest and post my results. If it works, then their is some weird
>> flaw with repo....
>>
>> Bill
>>
>> On Sat, Jul 28, 2012 at 1:28 PM, William Roberts
>> <bill.c.roberts@gmail.com>  wrote:
>>> That's strange because it worked before with stuff that was outside of
>>> the normal path, like selinux/libselinux. I definitely thing they
>>> intended to use name as that matches up with he remote
>>> and not the local checkout path. I started syncing with the new local
>>> manifest 1 project at a time and it seems to be working ok. Somewhere
>>> it just hangs and I haven't thrown repo into a debugger to see why.
>>>
>>> Bill
>>>
>>> On Sat, Jul 28, 2012 at 10:00 AM, Joshua Brindle<method@manicmethod.com>  wrote:
>>>> William Roberts wrote:
>>>>> Recently, I used a SE Android mirror.
>>>>>
>>>>> After the repository was initialized with --mirror I had a cron job
>>>>> the updated us every night through script. The script would repo init
>>>>> (on the appropriate branch) pull the local manifest over .repo and
>>>>> sync again. This all worked until the projects moved to bitbucket, now
>>>>> for some reason it dies, it literally hangs checking out the objects.
>>>>>
>>>>> I then merged the local manifest project paths and branches into my
>>>>> manifest to other people in my team can just do a checkout with repo
>>>>> init -b seandroid (and others)
>>>>>
>>>>> Did anyone else have something similar setup and did they have similar
>>>>> issues? Does anyone possibly know the cause?
>>>>
>>>> I'm doing the same thing. The issue I had was that the bitbucket repos are
>>>> formatted like "device-moto-wingray" instead of device/moto/wingray so my
>>>> mirror started checking out new repos and generally changing the directory
>>>> layout of the mirror. I guess I could have copied everything over to the new
>>>> locations and updated all the manifests but I found it lazier to "fix" repo,
>>>> I'm not sure if they intended to do this or not:
>>>>
>>>> diff --git a/manifest_xml.py b/manifest_xml.py
>>>> index a46cf24..a4c56e6 100644
>>>> --- a/manifest_xml.py
>>>> +++ b/manifest_xml.py
>>>> @@ -570,9 +570,9 @@ class XmlManifest(object):
>>>>         groups.append('default')
>>>>
>>>>       if self.IsMirror:
>>>> -      relpath = None
>>>> +      #relpath = None
>>>>         worktree = None
>>>> -      gitdir = os.path.join(self.topdir, '%s.git' % name)
>>>> +      gitdir = os.path.join(self.topdir, '%s.git' % path)
>>>>       else:
>>>>         worktree = os.path.join(self.topdir, path).replace('\\', '/')
>>>>         gitdir = os.path.join(self.repodir, 'projects/%s.git' % path)
>>>
>>>
>>> --
>>> Respectfully,
>>>
>>> William C Roberts
>>
>>
>> --
>> Respectfully,
>>
>> William C Roberts
>
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
