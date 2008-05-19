Subject: Re: File_contexts file and semanage...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D049AF445@de01exm68.ds.mot.com>
References: <4820D9FB.8010802@martinorr.name>
	 <1210248530.6434.145.camel@moss-spartans.epoch.ncsc.mil>
	 <482E1DCD.1000505@manicmethod.com>
	 <D06FE0A2807BC145B0D38744789D4F5D049AF445@de01exm68.ds.mot.com>
Content-Type: text/plain
Date: Mon, 19 May 2008 14:33:38 -0400
Message-Id: <1211222019.7486.64.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-05-19 at 14:07 -0400, Hasan Rezaul-CHR010 wrote:
> Hi All,
> 
> I have some unique directories in my filesystem, that I wanted to label
> a certain way. As such, I added a few modifications to the file_contexts
> files at the following locations:
> 
> /etc/selinux/strict/modules/active/file_contexts
> /etc/selinux/strict/modules/active/file_contexts.template
> /etc/selinux/strict/contexts/files/file_contexts
> 
> When my Linux machine boots up, and I label the entire filesystem,
> everything gets labelled correctly.
> 
> Later, I have a script that runs the  "semanage login -a -s xxx yyy"
> command.
> I noticed, right after the 'semanage' command is run, the above three
> files get reset back to the original defaults ???
> 
> Why does this happen, and any way for these file_contexts files to
> remain the way I set them initially ???

You shouldn't ever directly edit files under the modules/ subdirectory,
as they are managed by libsemanage, and the files you are touching are
generated based on other files.

Instead, use semanage fcontext -a to add local file contexts entries, or
put a file_contexts file in a policy module package (.pp) file of your
own and insert it via semodule.

> Ques 2.  Initially after the system is labelled the way I want,  the
> /etc/shadow file is labelled as  shadow_t !
> Later, some application task on my system is probably running "useradd"
> or "userdel", and as a result, I have two files labelled as follows:
> 
> /etc/shadow    etc_runtime_t
> /etc/shadow-   shadow_t
> 
> 
> It looks like useradd or userdel is creating a backup copy (shadow-),
> but I am not interested in that. The shadow file is what I am interested
> in, and its label is getting changed to  etc_runtime_t.  Why could this
> be happenning, and how do I stop it ?

The shadow file is updated by creating a new copy, creating a hard link
to the old copy, and then renaming the new copy into place such that the
shadow file is always in a valid state and the transaction is atomic.

Normally we preserve the type on the shadow file in two ways:
- policy defines a type transition for programs like useradd such that
any new files created by them will default to shadow_t if not otherwise
specified, and
- programs like useradd and/or the libraries they use to
modify /etc/shadow have been modified to preserve the security context
of the original file when making updates

Are your useradd and/or userdel programs from the shadow-utils package?
What version?  Does it include the SELinux modifications?

> Thanks in advance for your help,
> 
> - Rezaul.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
