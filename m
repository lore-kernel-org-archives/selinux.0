Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8HHIgYe021144
	for <selinux@tycho.nsa.gov>; Mon, 17 Sep 2007 13:18:42 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l8HHIfPX018406
	for <selinux@tycho.nsa.gov>; Mon, 17 Sep 2007 17:18:41 GMT
Subject: Re: [refpolicy] updated awstats policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <F132C258-18C1-456D-8679-430EE55597A9@sf-net.com>
References: <F132C258-18C1-456D-8679-430EE55597A9@sf-net.com>
Content-Type: text/plain
Date: Mon, 17 Sep 2007 17:16:58 +0000
Message-Id: <1190049418.17544.9.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2007-09-02 at 09:04 -0400, Stefan Schulze Frielinghaus wrote:
> After reading Dan's article about writing SELinux policies I decided 
> to remove the awstats_conf_t type. He suggests to only declare an 
> extra type if there is something to protect. The config files of 
> awstats do not include any sensitive data. The default installation 
> even permit unix world readable permissions.
> 
> Second (the most important bug I wrote ;-)) the awstats cgi script 
> was allowed to manage awstats_lib_t files which is _not_ necessary. I 
> allowed that because awstats_t executes the 
> httpd_awstats_script_exec_t to update the statistic files. But the 
> cgi script called from a web interface only needs read permissions so 
> I added an interface awstats_cgi_exec to handle this situation. Now 
> awstats_t executes httpd_awstats_script_exec_t in its domain which is 
> the preferred and more secure way.
> In the end the untrustworthy cgi script has only read access to 
> awstats_lib_t and awstats_t which is called from a trustworthy cron-
> job has write permissions to awstats_lib_t
> 
> Please substitute the old ("insecure") awstats policy with the new
> one.

Merged, with some reorganization.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
