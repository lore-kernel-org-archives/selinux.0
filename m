Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1CHrqPx011844
	for <selinux@tycho.nsa.gov>; Tue, 12 Feb 2008 12:53:52 -0500
Received: from fg-out-1718.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1CHrmDK011824
	for <selinux@tycho.nsa.gov>; Tue, 12 Feb 2008 17:53:48 GMT
Received: by fg-out-1718.google.com with SMTP id 16so3772295fgg.40
        for <selinux@tycho.nsa.gov>; Tue, 12 Feb 2008 09:53:46 -0800 (PST)
Message-ID: <cadfc0e40802120953i324f078eq94d8a4187424094@mail.gmail.com>
Date: Tue, 12 Feb 2008 11:53:46 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "Eamon Walsh" <ewalsh@tycho.nsa.gov>
Subject: Re: [PATCH] libselinux: add "poly_property" type to X contexts backend
Cc: "SELinux List" <selinux@tycho.nsa.gov>,
        "Stephen Smalley" <sds@tycho.nsa.gov>
In-Reply-To: <47AA0A2C.6090009@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47A8D586.7080202@tycho.nsa.gov>
	 <cadfc0e40802051412p393dd42ei3632bee0b9842b73@mail.gmail.com>
	 <47A9047D.1000501@tycho.nsa.gov> <47A9DA5D.2030109@sun.com>
	 <47AA0A2C.6090009@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Feb 6, 2008 at 1:27 PM, Eamon Walsh <ewalsh@tycho.nsa.gov> wrote:
> Glenn Faden wrote:
>  > Eamon Walsh wrote:
>  >
>  >> Xavier Toth wrote:
>  >>
>  >>> I'm curious as to why you chose the route of specifying which
>  >>> properties are polyinstantiated instead of which are not bearing in
>  >>> mind what Glenn said in a previous post?
>  >>>
>  >>>
>  >> The server will check the "property" lines first and if it doesn't
>  >> find a match it will check the "poly_property" lines.  So, as long as
>  >> the wildcard entry in the x_contexts file is changed from property to
>  >> poly_property, the default will be to polyinstantiate.
>  >>
>  >> However I wasn't planning on treating the root window any differently
>  >> from other windows, so this behavior would apply to all windows.
>  >>
>  > I've never seen a requirement for polyinstantiation of properties on
>  > per-client windows. I've seen requirements for relabeling properties,
>  > however. For example, the trusted selection manager needs to create
>  > properties that are readable by the client who requests a
>  > ConvertSelection. We do this by calling a new X protocol extension.
>
>  SELinux protocol extension allows clients to create windows and
>  properties with different security contexts.
>
>
>  >  How
>  > do you plan to have trusted clients act on behalf of other clients with
>  > different security contexts?
>
>  I haven't done the polyinstantiation for selections yet, but my current
>  plan is to implement a trusted clipboard manager that will display the
>  various clipboard contents and allow users to upgrade or downgrade,
>  which means that the clipboard manager will take ownership of the
>  selection at the target level and just pipe the data through.  This
>  scheme shouldn't require tweaking properties on the fly.  However this
>  would not be point-to-point but would make the selection available to
>  all applications at the target level.
>


Are you thinking of starting with an existing clipboard manager like Glipper?


>
>  > Similarly, how can a trusted client
>  > read/write a polyinstantiated property with a different security context?
>  >
>
>  By launching a helper process at the appropriate level.
>
>
>  --
>
>
> Eamon Walsh <ewalsh@tycho.nsa.gov>
>  National Security Agency
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
