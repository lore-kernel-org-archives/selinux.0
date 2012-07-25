Message-ID: <1343215872.31528.14.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: What is the reason for the denial?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 25 Jul 2012 07:31:12 -0400
In-Reply-To: <CAO-4OdF58aU5s=t5qeQiMOafGHjJTEQL7NpqnW0dAXjzmAOrgQ@mail.gmail.com>
References: 
	<CAO-4OdF58aU5s=t5qeQiMOafGHjJTEQL7NpqnW0dAXjzmAOrgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-07-24 at 15:25 -0700, Haiqing Jiang wrote:
> Hi, all
> 
> 
> I have the following denial. It's very strange since there is one
> policy in app.te: "allow appdomain app_data_file:notdevfile_class_set
> create_file_perms;"
> Therefore, this denial should not be existed. Do you have any ideas?
> Thanks. 
> 
> 
> #============= browser_app ==============
> allow browser_app app_data_file:file open;
> 
> <5>[12332.713684] type=1400 audit(1342643713.703:2221): avc:  denied
>  { open } for  pid=25996 comm="WebViewCoreThre"
> name="jsfileaccess.html" dev=mmcblk0p12 ino=578608
> scontext=u:r:browser_app:s0:c3
> tcontext=u:object_r:app_data_file:s0:c37 tclass=file
> <5>[12332.933044] type=1400 audit(1342643713.921:2222): avc:  denied
>  { open } for  pid=25996 comm="WebViewCoreThre" name="target.txt"
> dev=mmcblk0p12 ino=578521 scontext=u:r:browser_app:s0:c3
> tcontext=u:object_r:app_data_file:s0:c37 tclass=file

Violates the mlsconstrain statement on lines 72-73 of sepolicy/mls due
to different MLS categories (c3 vs c37).  This is our approach to
ensuring isolation of app processes and files from other apps that is
not dependent on app correctness (unlike the DAC permissions, as
illustrated in the Skype and Lookout Mobile examples in our prior
presentations).  Each app UID is mapped to a unique MLS category when
levelFromUid=true in seapp_contexts.

If we have to relax the restriction, then options include:
- Rather than using MLS for per-app isolation, we could just use it for
specific groups of apps via level= rather than levelFromUid=.

- Or we could isolate only based on app domain/type.  We recently
introduced support for specifying not only domain= but also type= based
on seinfo= strings in seapp_contexts, so you could in fact define and
assign different types for each app domain, e.g. platform_app_data_file,
media_app_data_file, etc.  Then we wouldn't use the MLS levels at all at
least in the default configuration.

- Labeling different subdirectories of the /data/data/<packagename>
directory differently so that we can for example apply this restriction
on the files/ subdirectory (private app files) but relax it for the
sharedprefs/ subdirectory.  This would require code changes to support.
We experimented briefly with this previously; if you want to go down
this route, let us know and we can dig out the older patch.  Not clear
if this would help with your particular issue - where does that file
live?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
