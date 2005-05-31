Date: Tue, 31 May 2005 22:12:48 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   "'Stephen Smalley'" <sds@tycho.nsa.gov>, SELinux@tycho.nsa.gov,
   dwalsh@redhat.com, branden@debian.org
Subject: Re: file_type_auto_trans is not sufficient
Message-ID: <20050531211247.GE11815@lkcl.net>
References: <200505311632.j4VGW95F032656@gotham.columbia.tresys.com> <1117558114.4455.0.camel@dhcp83-8.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1117558114.4455.0.camel@dhcp83-8.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, May 31, 2005 at 12:48:34PM -0400, Ivan Gyurdiev wrote:
> 
> > I know - that is why I am suggesting that each application could use multiple
> > directories. That means that orbit might put files into multiple directories
> > that were previously created, e.g. both /tmp and /tmp/orbit.
> 
> I am not following this - can you give an example.
> 
> Say you have an application such as gconf, which stores its data 
> in /tmp/gconfd-$USER (so it needs to be able to create that). 
> GConf is linked to libORBit2, hence it needs to be able to
> create /tmp/orbit-$USER.
> 
> Running gconfd in an individual domain is possible (and that's exactly
> what I've done). Running orbit in its domain does not work (at least not
> without a dynamic transition), because it's library code.
> 
> Are you saying that either gconfd or orbit need to move their files
> outside their designated directory and into /tmp?
 
 into /tmp/gconfd/something-$USER.

 yep.

 maybe the way forward is to create a [tiny] library with two
 functions in it: one that creates /tmp/socket and another
 that opens it, convert all programs to use that library, then
 convert the library to create /tmp/dir/socket.
 
 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
