Message-ID: <707f057d0812262322r76bcc43at51406c66b98a7f2a@mail.gmail.com>
Date: Sat, 27 Dec 2008 15:22:35 +0800
From: "xing li" <lixing.1006@gmail.com>
To: Tim <timasyk@gmail.com>, SELinux@tycho.nsa.gov
Subject: Re: Alternative location of policy files
In-Reply-To: <707f057d0812262321w4234ddabuc634f80a84cf5a9c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_33459_30401962.1230362555664"
References: <a5e2b64d0812232358u19f442dfwd27da7f0978a508c@mail.gmail.com>
	 <4951FA70.6000100@city-fan.org> <495204F4.4070301@gmail.com>
	 <49534D18.2030808@gmail.com>
	 <a5e2b64d0812250536u67aa89e8p3686225db08e6d06@mail.gmail.com>
	 <A819CC90-EBD7-4AD6-B5BC-E38CE5E7150D@gmail.com>
	 <a5e2b64d0812261733pcba86d1kbccc9e8a16566871@mail.gmail.com>
	 <707f057d0812262321w4234ddabuc634f80a84cf5a9c@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_33459_30401962.1230362555664
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2008/12/27 xing li <lixing.1006@gmail.com>

>
> It's work was rearly done in the "/sbin/init"  until the last step of
> system initialization, while the source
> of "/sbin/init" is included in the sysvinit. and it finally invoked
> "security_load_policy()" to load the binary
> policy "policy.XX" to the kernel structure policydb.
>
> and i have confused by the question:
> when and how the selinux label the all file system according
> to "file_contexts"?
> and i found the clue that when we "touch /.autorelabel",the system would
> invoke
> "fixfiles relabel" to relabel the file system. but i could't find the
> relevant source code.
> Maybt somebody has investigated that and could share infomation?
>
> 2008/12/27 Tim <timasyk@gmail.com>
>
> OK. I'm trying to trace Linux sources to find exact sequence of
>> function calls for loading  SELinux policy into Linux kernel at boot
>> time. And I've lost... to many calls to trace.
>>
>> Maybe somebody has that tracing already and can share information?
>>
>> Tim
>>
>> 2008/12/26 Justin P. Mattock <justinmattock@gmail.com>:
>>  > I think, one of the main jobs
>> > For libselinux is reading the
>> > Policy, from it specefied location
>> > And then mounting the selinuxfs.
>> > Or vise versa mounting selinuxfs,
>> > And then reading the policy. As
>> > For changing the location, not
>> > To sure what the code looks like,
>> > Maybe it's just a few liners to
>> > Do what you wanted.
>> >
>> > justin P. Mattock
>> >
>> >
>> >
>> > On Dec 25, 2008, at 5:36 AM, Tim <timasyk@gmail.com> wrote:
>> >
>> >> 2008/12/25 Justin P. Mattock <justinmattock@gmail.com>:
>> >>>
>> >>> Justin P. Mattock wrote:
>> >>>>
>> >>>> Paul Howarth wrote:
>> >>>>>
>> >>>>> Tim wrote:
>> >>>>>>
>> >>>>>> Hello all,
>> >>>>>>
>> >>>>>> I was wondering, how can I change default location of SELinux
>> policy
>> >>>>>> from /etc/selinux/_policyname_ to some other path?
>> >>>>>> What source codes should be modified for that?
>> >>>>>>
>> >>>>>> The reason to do that are:
>> >>>>>> - I want to work with loadable policy modules --> that requires
>> >>>>>> /etc/selinux/_policyname_ directory to be writable.
>> >>>>>> - limitation of my filesystem having /etc directory (it is
>> read-only
>> >>>>>> filesystem)
>> >>>>>> - unfortunately, I can not mount /etc into some other writable
>> >>>>>> filesystem
>> >>>>>
>> >>>>> Perhaps you could mount /etc/selinux/_policyname_ rather than /etc
>> from
>> >>>>> a
>> >>>>> writeable filesystem?
>> >>>>>
>> >>>>> Paul.
>> >>>>> cy
>> >>>>> --
>> >>>>> This message was distributed to subscribers of the selinux mailing
>> >>>>> list.
>> >>>>> If you no longer wish to subscribe, send mail to
>> >>>>> majordomo@tycho.nsa.gov
>> >>>>> with
>> >>>>> the words "unsubscribe selinux" without quotes as the message.
>> >>>>>
>> >>>> This is confusing to me:
>> >>>> it sounds like there not trying to mount
>> >>>> SELinux, but have the policy load
>> >>>> in a different location other than
>> >>>> /etc/selinux/*
>> >>>>
>> >>>> regards;
>> >>>>
>> >>>> Justin P. Mattock
>> >>>>
>> >>>>
>> >>> On second thought  from what  it  sounds,
>> >>> to have SELinux be read in another location,
>> >>> you would have to locate in
>> >>> libselinux the location from where the library is
>> >>> told to read the the policy, and simple just change the location,
>> >>> but then you might have to change the kernel, all the libraries,
>> >>> all apps, etc.. that read /etc/selinux/*
>> >>> maybe a simple change of /etc/selinux/config
>> >>> seems simpler. rather than going through
>> >>> lines of code.
>> >>> Anyways,
>> >>> "Merry christmas"
>> >>>
>> >>>
>> >>> regards;
>> >>>
>> >>> Justin P. Mattock
>> >>
>> >> You are right. I would like kernel to read policy just from different
>> >> location.
>> >>
>> >> So options are as folowing:
>> >> 1. Change libselinux sources and sources of all related apps + kernel.
>> >> 2. Try to change /etc/selinux/config.
>> >>
>> >> Regarding second one - manuals on SELinux say that /etc/selinux/config
>> >> contains name of policy to be loaded. And that name _policyname_ is a
>> >> name of directory in /etc/selinux/_policyname_ having subdirectory
>> >> policy with actual policy file.
>> >>
>> >> So, it seems only option #1 is the one to use.
>> >>
>> >> Does kernel use libselinux to read policy or it reads it directly from
>> >> filesystem?
>> >> Any other pitfalls?
>> >>
>> >> Tim
>> >
>>
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.govwith
>> the words "unsubscribe selinux" without quotes as the message.
>>
>
>

------=_Part_33459_30401962.1230362555664
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br>
<div class="gmail_quote">2008/12/27 xing li <span dir="ltr">&lt;<a href="mailto:lixing.1006@gmail.com">lixing.1006@gmail.com</a>&gt;</span><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div><br>It&#39;s work was&nbsp;rearly done in the &quot;/sbin/init&quot;&nbsp;&nbsp;until the last step of system initialization, while the&nbsp;source</div>
<div>of &quot;/sbin/init&quot; is included in the sysvinit.&nbsp;and it finally invoked &quot;security_load_policy()&quot; to load the binary</div>
<div>policy &quot;policy.XX&quot; to the kernel structure policydb.</div>
<div>&nbsp;</div>
<div>and i&nbsp;have confused by the question:</div>
<div>when and how the selinux label the all file system according to&nbsp;&quot;file_contexts&quot;?</div>
<div>and i&nbsp;found the clue that when we &quot;touch /.autorelabel&quot;,the system would invoke </div>
<div>&quot;fixfiles relabel&quot; to relabel the file system. but i could&#39;t find the relevant source code.</div>
<div>Maybt somebody has investigated that and could share infomation?</div>
<div>&nbsp;</div>
<div class="gmail_quote">2008/12/27 Tim <span dir="ltr">&lt;<a href="mailto:timasyk@gmail.com" target="_blank">timasyk@gmail.com</a>&gt;</span> 
<div>
<div></div>
<div class="Wj3C7c"><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">OK. I&#39;m trying to trace Linux sources to find exact sequence of<br>function calls for loading &nbsp;SELinux policy into Linux kernel at boot<br>
time. And I&#39;ve lost... to many calls to trace.<br><br>Maybe somebody has that tracing already and can share information?<br><br>Tim<br><br>2008/12/26 Justin P. Mattock &lt;<a href="mailto:justinmattock@gmail.com" target="_blank">justinmattock@gmail.com</a>&gt;:<br>

<div>
<div></div>
<div>&gt; I think, one of the main jobs<br>&gt; For libselinux is reading the<br>&gt; Policy, from it specefied location<br>&gt; And then mounting the selinuxfs.<br>&gt; Or vise versa mounting selinuxfs,<br>&gt; And then reading the policy. As<br>
&gt; For changing the location, not<br>&gt; To sure what the code looks like,<br>&gt; Maybe it&#39;s just a few liners to<br>&gt; Do what you wanted.<br>&gt;<br>&gt; justin P. Mattock<br>&gt;<br>&gt;<br>&gt;<br>&gt; On Dec 25, 2008, at 5:36 AM, Tim &lt;<a href="mailto:timasyk@gmail.com" target="_blank">timasyk@gmail.com</a>&gt; wrote:<br>
&gt;<br>&gt;&gt; 2008/12/25 Justin P. Mattock &lt;<a href="mailto:justinmattock@gmail.com" target="_blank">justinmattock@gmail.com</a>&gt;:<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; Justin P. Mattock wrote:<br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt; Paul Howarth wrote:<br>
&gt;&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&gt; Tim wrote:<br>&gt;&gt;&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&gt;&gt; Hello all,<br>&gt;&gt;&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&gt;&gt; I was wondering, how can I change default location of SELinux policy<br>
&gt;&gt;&gt;&gt;&gt;&gt; from /etc/selinux/_policyname_ to some other path?<br>&gt;&gt;&gt;&gt;&gt;&gt; What source codes should be modified for that?<br>&gt;&gt;&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&gt;&gt; The reason to do that are:<br>
&gt;&gt;&gt;&gt;&gt;&gt; - I want to work with loadable policy modules --&gt; that requires<br>&gt;&gt;&gt;&gt;&gt;&gt; /etc/selinux/_policyname_ directory to be writable.<br>&gt;&gt;&gt;&gt;&gt;&gt; - limitation of my filesystem having /etc directory (it is read-only<br>
&gt;&gt;&gt;&gt;&gt;&gt; filesystem)<br>&gt;&gt;&gt;&gt;&gt;&gt; - unfortunately, I can not mount /etc into some other writable<br>&gt;&gt;&gt;&gt;&gt;&gt; filesystem<br>&gt;&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&gt; Perhaps you could mount /etc/selinux/_policyname_ rather than /etc from<br>
&gt;&gt;&gt;&gt;&gt; a<br>&gt;&gt;&gt;&gt;&gt; writeable filesystem?<br>&gt;&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&gt; Paul.<br>&gt;&gt;&gt;&gt;&gt; cy<br>&gt;&gt;&gt;&gt;&gt; --<br>&gt;&gt;&gt;&gt;&gt; This message was distributed to subscribers of the selinux mailing<br>
&gt;&gt;&gt;&gt;&gt; list.<br>&gt;&gt;&gt;&gt;&gt; If you no longer wish to subscribe, send mail to<br>&gt;&gt;&gt;&gt;&gt; <a href="mailto:majordomo@tycho.nsa.gov" target="_blank">majordomo@tycho.nsa.gov</a><br>&gt;&gt;&gt;&gt;&gt; with<br>
&gt;&gt;&gt;&gt;&gt; the words &quot;unsubscribe selinux&quot; without quotes as the message.<br>&gt;&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt; This is confusing to me:<br>&gt;&gt;&gt;&gt; it sounds like there not trying to mount<br>
&gt;&gt;&gt;&gt; SELinux, but have the policy load<br>&gt;&gt;&gt;&gt; in a different location other than<br>&gt;&gt;&gt;&gt; /etc/selinux/*<br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt; regards;<br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt; Justin P. Mattock<br>
&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt; On second thought &nbsp;from what &nbsp;it &nbsp;sounds,<br>&gt;&gt;&gt; to have SELinux be read in another location,<br>&gt;&gt;&gt; you would have to locate in<br>&gt;&gt;&gt; libselinux the location from where the library is<br>
&gt;&gt;&gt; told to read the the policy, and simple just change the location,<br>&gt;&gt;&gt; but then you might have to change the kernel, all the libraries,<br>&gt;&gt;&gt; all apps, etc.. that read /etc/selinux/*<br>&gt;&gt;&gt; maybe a simple change of /etc/selinux/config<br>
&gt;&gt;&gt; seems simpler. rather than going through<br>&gt;&gt;&gt; lines of code.<br>&gt;&gt;&gt; Anyways,<br>&gt;&gt;&gt; &quot;Merry christmas&quot;<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; regards;<br>&gt;&gt;&gt;<br>
&gt;&gt;&gt; Justin P. Mattock<br>&gt;&gt;<br>&gt;&gt; You are right. I would like kernel to read policy just from different<br>&gt;&gt; location.<br>&gt;&gt;<br>&gt;&gt; So options are as folowing:<br>&gt;&gt; 1. Change libselinux sources and sources of all related apps + kernel.<br>
&gt;&gt; 2. Try to change /etc/selinux/config.<br>&gt;&gt;<br>&gt;&gt; Regarding second one - manuals on SELinux say that /etc/selinux/config<br>&gt;&gt; contains name of policy to be loaded. And that name _policyname_ is a<br>
&gt;&gt; name of directory in /etc/selinux/_policyname_ having subdirectory<br>&gt;&gt; policy with actual policy file.<br>&gt;&gt;<br>&gt;&gt; So, it seems only option #1 is the one to use.<br>&gt;&gt;<br>&gt;&gt; Does kernel use libselinux to read policy or it reads it directly from<br>
&gt;&gt; filesystem?<br>&gt;&gt; Any other pitfalls?<br>&gt;&gt;<br>&gt;&gt; Tim<br>&gt;<br><br>--<br>This message was distributed to subscribers of the selinux mailing list.<br>If you no longer wish to subscribe, send mail to <a href="mailto:majordomo@tycho.nsa.gov" target="_blank">majordomo@tycho.nsa.gov</a> with<br>
the words &quot;unsubscribe selinux&quot; without quotes as the message.<br></div></div></blockquote></div></div></div><br></blockquote></div><br>

------=_Part_33459_30401962.1230362555664--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
