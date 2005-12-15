Message-ID: <6c18a4f0512151537v2332d13dod48c3bfef81db5a8@mail.gmail.com>
Date: Fri, 16 Dec 2005 00:37:19 +0100
From: Bernd Bartmann <bernd.bartmann@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: RHES4, Subversion, Apache and SElinux
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <43A1FC43.3050100@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <6c18a4f0512151401p3948e810g5bec34eabbce522c@mail.gmail.com>
	 <43A1F9DC.3010205@redhat.com>
	 <6c18a4f0512151526u137caa8fo4dd44f92551369c7@mail.gmail.com>
	 <43A1FC43.3050100@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/16/05, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Bernd Bartmann wrote:
> > On 12/16/05, Daniel J Walsh <dwalsh@redhat.com> wrote:
> >
> >> file_t indicates that the file system was never labeled.
> >> try chcon -R -t httpd_sys_content_t /data
> >> to label the entire tree.
> >>
> >
> > This results in:
> > [root@picard ~]# chcon -R -t httpd_sys_content_t /data
> > chcon: can't apply partial context to unlabeled file /data
> >
> > I seem to be able to anything below /data but not /data itself.
> >
> chcon -R system_u:object_r:httpd_sys_content_t /data

Thanks. This works perfectly.

Best regards,
Bernd.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
