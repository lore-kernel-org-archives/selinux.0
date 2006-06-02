From: David Howells <dhowells@redhat.com>
In-Reply-To: <1149254831.7506.11.camel@moss-tarheels.epoch.ncsc.mil> 
References: <1149254831.7506.11.camel@moss-tarheels.epoch.ncsc.mil> 
To: Michael LeMay <mdlemay@epoch.ncsc.mil>
Cc: jmorris@redhat.com, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        dhowells@redhat.com
Subject: Re: [PATCH] selinux: Kernel access key retention support for SELinux 
Date: Fri, 02 Jun 2006 14:38:23 +0100
Message-ID: <13139.1149255503@warthog.cambridge.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Michael LeMay <mdlemay@epoch.ncsc.mil> wrote:

> Let me know if you see anything else that needs to be changed in this
> version...

I'd like:

> +Currently, all of the basic permissions explained above are provided in SELinux
> +as well, and are always checked immediately after any discretionary permission
> +checks are performed.

changing to:

+Currently, all of the basic permissions explained above are provided in SELinux
+as well; SE Linux is simply invoked after all basic permission checks have been
+performed.


I think that in what you said "and are always checked" refers grammatically to
"all of the basic permissions" - at least, that's the way I understood it.

Documentation takes as much skill, debugging and bloody-mindedness as the code
to which it refers:-).

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
