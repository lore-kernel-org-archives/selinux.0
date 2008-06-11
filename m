Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5CCFhOI003649
	for <selinux@tycho.nsa.gov>; Thu, 12 Jun 2008 08:15:43 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5CCFgOd007920
	for <selinux@tycho.nsa.gov>; Thu, 12 Jun 2008 12:15:43 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1) with ESMTP id m5CCDtm5020360
	for <selinux@tycho.nsa.gov>; Thu, 12 Jun 2008 08:13:55 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1/Submit) id m5CCDt6j020359
	for selinux@tycho.nsa.gov; Thu, 12 Jun 2008 08:13:55 -0400
Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5BKspvH028018
	for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 16:54:51 -0400
Message-ID: <48503B9A.1060700@tycho.nsa.gov>
Date: Wed, 11 Jun 2008 16:54:50 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Xavier Toth <txtoth@gmail.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: how do I use selabel to get an x selection object context
References: <cadfc0e40806111317m13da0f13s1288ef788a877d55@mail.gmail.com>
In-Reply-To: <cadfc0e40806111317m13da0f13s1288ef788a877d55@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Xavier Toth wrote:
> I could use an example of using selabel to get a x object context if
> anyone has one.
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>
>   

Opening a handle:

    label_hnd = selabel_open(SELABEL_CTX_X, NULL, 0);
    if (!label_hnd)
	FatalError("SELinux: Failed to open x_contexts mapping in policy\n");



Doing a lookup:

    if (selabel_lookup(label_hnd, &ctx, name, SELABEL_X_SELN) < 0)
	FatalError("SELinux: A lookup failed!");



Closing:

    freecon(ctx);
    selabel_close(label_hnd);


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
