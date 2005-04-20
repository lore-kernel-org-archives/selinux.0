Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3K2Ed7C027348
	for <selinux@tycho.nsa.gov>; Tue, 19 Apr 2005 22:14:54 -0400 (EDT)
Received: from wproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3K27Am9007966
	for <selinux@tycho.nsa.gov>; Wed, 20 Apr 2005 02:07:10 GMT
Received: by wproxy.gmail.com with SMTP id 50so30443wri
        for <selinux@tycho.nsa.gov>; Tue, 19 Apr 2005 19:09:55 -0700 (PDT)
Message-ID: <fa8ec5d805041919096c4391a0@mail.gmail.com>
Date: Tue, 19 Apr 2005 22:09:52 -0400
From: Kodungallur Varma <ramgwu@gmail.com>
Reply-To: Kodungallur Varma <ramgwu@gmail.com>
To: selinux@tycho.nsa.gov
Subject: attributes on the other end of a network connection
Cc: sds@tycho.nsa.gov
In-Reply-To: <1112186117.8012.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa8ec5d80503082008161e5619@mail.gmail.com>
	 <20050309084655.GC5236@thorium.jmh.mhn.de>
	 <fa8ec5d805031118353197f745@mail.gmail.com>
	 <1110812772.21378.79.camel@moss-spartans.epoch.ncsc.mil>
	 <fa8ec5d8050328195571c9d4fc@mail.gmail.com>
	 <1112107028.4339.34.camel@moss-spartans.epoch.ncsc.mil>
	 <fa8ec5d8050329194145add881@mail.gmail.com>
	 <1112186117.8012.5.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,

        I have a basic client and a server program. my server has the
capability to setcon() to a new domain, the client domain precisely.
my server needs to find the domain and user name of the client user(my
client tries to get a tcp connection first). I heard there is a
function which gives the context and attributes of the other end,
given the attributes got at the servers end and vice-versa. I dont
know where exactly to look for that function capability, but I am
starting in the libselinux library. for security reasons, my client
also needs to be able to execute this function to get the attributes
of the server, just to know that it is connecting to the right server.
if anyone knows about any such function, please pass on to me. thanx a lot..

Ram

On 3/30/05, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Tue, 2005-03-29 at 22:41 -0500, Kodungallur Varma wrote:
> > thanx a lot..the program worked. however I need to change the policy
> > file(.te) often and so I need to make load it. I am unable to do that
> > at the moment due to the problem that I updated the following without
> > updating my policy:
> >
> > checkpolicy-1.22
> > libsepol-1.4
> > policycoreutils-1.22
> >
> > how do I uninstall them??
> 
> You can grab the older checkpolicy, libsepol, and policycoreutils
> packages from FC3 and re-install them with rpm -Uvh --oldpackage.
> 
> >  also I tried the alternative to update my
> > policy by doing:
> > "yum install selinux-policy-strict-sources" and "yum install
> > selinux-policy-targeted-sources". the targeted version was updated,
> > but strict had "nothing to do". seems like it is up to date.
> 
> You would need to update to the rawhide (FC4 development) policy; FC3
> policy doesn't include these changes.
> 
> --
> Stephen Smalley <sds@tycho.nsa.gov>
> National Security Agency
> 
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
