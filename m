Message-ID: <526AB224.1@tycho.nsa.gov>
Date: Fri, 25 Oct 2013 14:02:12 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: eparis@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH 2/2] Need to delete all managed objects before readding
 them
References: <526987A1.1040204@redhat.com>
In-Reply-To: <526987A1.1040204@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/24/2013 04:48 PM, Daniel J Walsh wrote:
> We need to delete all modifications before we re-add them, otherwise we end up
> with conflicts on user/login mappings.

Thanks, both merged.





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
