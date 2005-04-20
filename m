Subject: Re: attributes on the other end of a network connection
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kodungallur Varma <ramgwu@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <fa8ec5d805041919096c4391a0@mail.gmail.com>
References: <fa8ec5d80503082008161e5619@mail.gmail.com>
	 <20050309084655.GC5236@thorium.jmh.mhn.de>
	 <fa8ec5d805031118353197f745@mail.gmail.com>
	 <1110812772.21378.79.camel@moss-spartans.epoch.ncsc.mil>
	 <fa8ec5d8050328195571c9d4fc@mail.gmail.com>
	 <1112107028.4339.34.camel@moss-spartans.epoch.ncsc.mil>
	 <fa8ec5d8050329194145add881@mail.gmail.com>
	 <1112186117.8012.5.camel@moss-spartans.epoch.ncsc.mil>
	 <fa8ec5d805041919096c4391a0@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 20 Apr 2005 08:19:36 -0400
Message-Id: <1113999576.1028.41.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-04-19 at 22:09 -0400, Kodungallur Varma wrote:
> Hi all,
> 
>         I have a basic client and a server program. my server has the
> capability to setcon() to a new domain, the client domain precisely.
> my server needs to find the domain and user name of the client user(my
> client tries to get a tcp connection first). I heard there is a
> function which gives the context and attributes of the other end,
> given the attributes got at the servers end and vice-versa. I dont
> know where exactly to look for that function capability, but I am
> starting in the libselinux library. for security reasons, my client
> also needs to be able to execute this function to get the attributes
> of the server, just to know that it is connecting to the right server.
> if anyone knows about any such function, please pass on to me. thanx a lot..

That requires some form of labeled networking support, which doesn't
exist in the mainline SELinux presently.  Older SELinux had an
experimental labeled networking implementation (Selopt) by James Morris
based on CIPSO/FIPS188 options, but the necessary security hooks and
fields weren't accepted into mainline Linux.  Trent Jaeger of IBM has
implemented implicit packet labeling based on IPSEC SA, and I believe
that there is work ongoing to provide such an interface using that
support, but that hasn't been merged yet.  getpeercon(3) is the existing
interface, but only works for Unix domain stream sockets presently, as
James noted.  

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
