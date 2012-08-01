MIME-Version: 1.0
In-Reply-To: <1343737896.13704.2.camel@moss-pluto.epoch.ncsc.mil>
References: <CAFftDdoBpZ9ruMjnBwiA9Cxh0L14xJiXh5LXam3V=n-jHTbYkg@mail.gmail.com>
	<1343737896.13704.2.camel@moss-pluto.epoch.ncsc.mil>
Date: Tue, 31 Jul 2012 18:46:52 -0700
Message-ID: <CAFftDdoOfz1MVsFKqa3ymCs_+pLhmZWVtrV=HRYzAT-LTA=aLA@mail.gmail.com>
Subject: Re: Cloning Android repo's from bitbucket
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen,
It didn't like the fetch url, this patch fixes it on master.

diff --git a/local_manifest.xml b/local_manifest.xml
index b3d6b49..ba7118d 100644
--- a/local_manifest.xml
+++ b/local_manifest.xml
@@ -1,6 +1,6 @@
 <manifest>
   <remote  name="bitbucket"
-           fetch="git@bitbucket.org:seandroid" />
+           fetch="git+ssh://git@bitbucket.org/seandroid/" />

   <remove-project name="platform/external/libselinux"/>
   <project path="external/libselinux" remote="bitbucket"
name="external-libselinux"/>

On Tue, Jul 31, 2012 at 5:31 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Mon, 2012-07-30 at 16:59 -0700, William Roberts wrote:
>> HTTPS checkouts of device-samsung-tuna fail, but the ssh clone worked for me.
>>
>> Can we get new local_manifest branches, that specify using the git/ssh
>> checkout as the fetch url instead of https?
>>
>> something like this:
>>
>> master <-- https
>> master-ssh <-ssh
>>
>> Keep is simple and consistent please so scripting is easy.
>>
>> The only downside is you must have a registered bitbucket account and
>> ssh keys set up, but thats not a major problem if people use those
>> branches!
>
> Done.  master-ssh, seandroid-4.0.4-ssh, seandroid-4.1.1-ssh branches
> created.
>
> --
> Stephen Smalley
> National Security Agency
>



-- 
Respectfully,

William C Roberts

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
