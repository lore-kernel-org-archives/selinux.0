Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7IHNUHa012849
	for <selinux@tycho.nsa.gov>; Mon, 18 Aug 2003 13:23:30 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h7IHM7OD022792
	for <selinux@tycho.nsa.gov>; Mon, 18 Aug 2003 17:22:07 GMT
Received: from mcfeely.r00td0wn.net (dsl093-212-010.clb1.dsl.speakeasy.net [66.93.212.10])
	by jazzswing.ncsc.mil  with ESMTP id h7IHM6KO022784
	for <selinux@tycho.nsa.gov>; Mon, 18 Aug 2003 17:22:06 GMT
Message-ID: <3F410B88.7090809@diyab.net>
Date: Mon, 18 Aug 2003 13:23:20 -0400
From: Diyab <diyab@diyab.net>
MIME-Version: 1.0
To: Kerry Thompson <kerry@crypt.gen.nz>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: SELinux on Slackware 9 with PAM
References: <3F3896BD.5000307@diyab.net> <3357.202.27.185.71.1061177252.squirrel@www.crypt.gen.nz>
In-Reply-To: <3357.202.27.185.71.1061177252.squirrel@www.crypt.gen.nz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Kerry Thompson wrote:
> I just got around to reading this, after carrying it around with me for
> almost a week now.
> 
> Its very useful document for anyone deploying SELinux on Slackware. The
> document pretty much follows the README and describes what changes need to
> be made for Slackware.
> 
> A few comments:
> 
> - you should mention that the Vixie crond in the SE release has been
> modified for SELinux and really needs to be installed if you want cron.
> Alternatively the user would need to modify Dillon's crond code to support
> the SELinux extensions.

I do kind of mention how it is modified just not in the introduction 
where I explain the changing of cronds.  I can fix that, it's just that 
I don't imagine many people running a machine without a crond of some sort.

> 
> - you don't seem to configure the kernel ( make menuconfig, or edit
> .config ) before compiling it - which may cause problems if the user has
> devices not in the standard config.
> 

In the instructions I direct the user to start at the "Step-by-Step 
Building and Installing" section and continue until they hit step one. 
The text between the step-by-step title and step one details applying 
the SELinux patch to the kernel tree as well as configuring and building 
the kernel.

> - be careful about specifying line numbers when describing changes to
> files - the line numbers will probably change in new releases of
> Slack/SELinux.

The line numbers won't be a problem even if the policies change since 
the policy will still compile.  I don't really see a better way to do 
this and still keep it simple for the reader though.  Did you have 
something in mind?

> 
> - I recommend converting the document to HTML, even if you just wrap <Hx>
> tages around the headers. Search engines give preference to keywords in
> HTML files and headers.

I had planned on this I just haven't had the time yet.  I made the 
initial document text so that everyone could read it no matter what they 
were using.  The PDF version is available now also.

> All in all a very useful document. Anyone installing on Slackware will
> save themselves a lot of time by referring to this.
> 
> Kerry
> 

Thanks for your feedback Kerry.

Timothy,

-- 
I put instant coffee in a microwave and almost went back in time.
		-- Steven Wright


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
