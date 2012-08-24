Message-ID: <1345809896.18849.12.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: sepol help
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: William Roberts <bill.c.roberts@gmail.com>, selinux@tycho.nsa.gov,
        Joshua Brindle <jbrindle@tresys.com>
Date: Fri, 24 Aug 2012 08:04:56 -0400
In-Reply-To: <5036E824.7030007@manicmethod.com>
References: 
	<CAFftDdrcyjQ53iEjQBK=tHROVR5fZVEPvC8wRxTT9ddx2j6FVA@mail.gmail.com>
	 <5036E824.7030007@manicmethod.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-08-23 at 22:34 -0400, Joshua Brindle wrote:
> William Roberts wrote:
> > I am working on a tool for parsing, and allowing overrides to occur in
> > seapp_contexts. I also want it to check the output selectors against
> > the compiled binary. After looking at sepol, it wasn't quite clear to
> > me how to get going with it. Can anyone give me function calls to do
> > something like this?
> >
> > 1. Load the compiled binary
> 
> look at checkpolicy/test/dispol.c for examples. requires you to be 
> statically linked against libsepol.
> 
>          fd = open(argv[1], O_RDONLY);
>          if (fd < 0) {
> ...        }
>          if (fstat(fd, &sb) < 0) {
> ...        }
>          map =
>              mmap(NULL, sb.st_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, 
> fd, 0);
>          if (map == MAP_FAILED) {
> ...        }
>          policy_file_init(&pf);
>          pf.type = PF_USE_MEMORY;
>          pf.data = map;
>          pf.len = sb.st_size;
>          if (policydb_init(&policydb)) {
> ...        }
>          ret = policydb_read(&policydb, &pf, 1);
> 
> 
> > 2. Check to see if a boolean exists
> 
> bool = hashtab_search(policydb->p_bools.table, "some_boolean");
> if (bool == null) {
> 	//no such boolean
> }

libsemanage and/or libselinux/src/audit2why.c shows how to do this more
cleanly using the sepol_* interfaces.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
