Date: Fri, 19 Apr 2002 16:20:12 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: Dale Amon <amon@vnl.com>,
        "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        <SELinux@tycho.nsa.gov>
Subject: Re: db conflict ?
In-Reply-To: <20020418154333.B804444D90@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0204191615090.18117-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 18 Apr 2002, Russell Coker wrote:

> Why not just have a file_contexts directory under the main policy directory?
>
> I think that having a single Makefile do them both is the best way to do it.
> In my current code base it will compile the policy before doing a relabel.
>
> Also with the new file_contexts scheme of separate files then the same
> Makefile needs to be used so it can determine which .fc files to use
> something like the following:
> FC_FILES=$(pathsubst domains/program/%.te,file_contexts/%.fc, $(wildcard
> domains/program/*.te))

I've moved the file contexts configuration under policy/file_contexts in
our tree and changed the policy Makefile to cover both policy builds and
relabeling.  The setfiles directory now merely contains the setfiles
program sources and a Makefile to build and install it.  I used your
definition above (except pathsubt->patsubst), and it appears to work
correctly with the partitioned file contexts.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
