Subject: Re: __thread and fork() is a big no-no
From: Colin Walters <walters@verbum.org>
To: Eric Paris <eparis@redhat.com>
Cc: sds@tycho.nsa.gov, selinux@tycho.nsa.gov
In-Reply-To: <1090524285.6034746.1358287131109.JavaMail.root@zmail12.collab.prod.int.phx2.redhat.com>
References: 
	 <1090524285.6034746.1358287131109.JavaMail.root@zmail12.collab.prod.int.phx2.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 15 Jan 2013 17:27:05 -0500
Message-ID: <1358288825.977.25.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2013-01-15 at 16:58 -0500, Eric Paris wrote:
> It is not about caching tid,  it is about ALL __thread variables not being cleared across fork. 

Using pthread_atfork() is a way to ensure it *is* cleared.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
