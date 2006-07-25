Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6PGkZtM026068
	for <selinux@tycho.nsa.gov>; Tue, 25 Jul 2006 12:46:36 -0400
Received: from nf-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6PGkYPQ013883
	for <selinux@tycho.nsa.gov>; Tue, 25 Jul 2006 16:46:35 GMT
Received: by nf-out-0910.google.com with SMTP id l24so2336nfc
        for <selinux@tycho.nsa.gov>; Tue, 25 Jul 2006 09:46:34 -0700 (PDT)
Message-ID: <46ffa45f0607250932n2d7d211ck547227cb06af040@mail.gmail.com>
Date: Tue, 25 Jul 2006 11:32:55 -0500
From: "Aleks Kissinger" <aleks0@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Bare bones SELinux Policy
Cc: "=?ISO-8859-1?Q?T=F6r=F6k_Edvin?=" <edwintorok@gmail.com>
In-Reply-To: <4354d3270607250852m23058dddn7135e9bd349ab5b6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <46ffa45f0607250834n4f7eec8dwcee09d808ffb2a6d@mail.gmail.com>
	 <4354d3270607250852m23058dddn7135e9bd349ab5b6@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sorry, I left out the attachment.  It's now posted here:
http://www.esg.utulsa.edu/downloads.html

On 7/25/06, Török Edvin <edwintorok@gmail.com> wrote:
> On 7/25/06, Aleks Kissinger <aleks0@gmail.com> wrote:
> > I've been doing a little bit of SELinux policy hacking, and as a
> > starting point, I wrote a tiny (600-line) allow-everything policy.  As
> > I had to jump through some hoops to get this working, I thought maybe
> > some of you out there could benefit from it.
> >
> > On Fedora 5 (and probably older), unzip the attchment in
> > '/etc/selinux', set SELINUXTYPE=simple in '/etc/selinux/config', and
> > run make load in '/etc/selinux/simple/src'.  Reboot.
> >
> > If you have any comments, suggestions, or improvements, I'd love to hear them.
> >
> The attachment didn't make it to the mailing list. Could you make it
> available for download somewhere?
>
> Regards,
> Edwin
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
