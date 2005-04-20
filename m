Date: Tue, 19 Apr 2005 23:44:47 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Kodungallur Varma <ramgwu@gmail.com>
cc: selinux@tycho.nsa.gov, <sds@tycho.nsa.gov>
Subject: Re: attributes on the other end of a network connection
In-Reply-To: <fa8ec5d805041919096c4391a0@mail.gmail.com>
Message-ID: <Xine.LNX.4.44.0504192343420.18397-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 19 Apr 2005, Kodungallur Varma wrote:

> Hi all,
> 
>         I have a basic client and a server program. my server has the
> capability to setcon() to a new domain, the client domain precisely.
> my server needs to find the domain and user name of the client user(my
> client tries to get a tcp connection first). I heard there is a
> function which gives the context and attributes of the other end,
> given the attributes got at the servers end and vice-versa.


The function you're looking for is getpeercon(3), which only currently 
works on Unix sockets.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
