Message-ID: <5036E824.7030007@manicmethod.com>
Date: Thu, 23 Aug 2012 22:34:12 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: William Roberts <bill.c.roberts@gmail.com>
CC: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: sepol help
References: <CAFftDdrcyjQ53iEjQBK=tHROVR5fZVEPvC8wRxTT9ddx2j6FVA@mail.gmail.com>
In-Reply-To: <CAFftDdrcyjQ53iEjQBK=tHROVR5fZVEPvC8wRxTT9ddx2j6FVA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

William Roberts wrote:
> I am working on a tool for parsing, and allowing overrides to occur in
> seapp_contexts. I also want it to check the output selectors against
> the compiled binary. After looking at sepol, it wasn't quite clear to
> me how to get going with it. Can anyone give me function calls to do
> something like this?
>
> 1. Load the compiled binary

look at checkpolicy/test/dispol.c for examples. requires you to be 
statically linked against libsepol.

         fd = open(argv[1], O_RDONLY);
         if (fd < 0) {
...        }
         if (fstat(fd, &sb) < 0) {
...        }
         map =
             mmap(NULL, sb.st_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, 
fd, 0);
         if (map == MAP_FAILED) {
...        }
         policy_file_init(&pf);
         pf.type = PF_USE_MEMORY;
         pf.data = map;
         pf.len = sb.st_size;
         if (policydb_init(&policydb)) {
...        }
         ret = policydb_read(&policydb, &pf, 1);


> 2. Check to see if a boolean exists

bool = hashtab_search(policydb->p_bools.table, "some_boolean");
if (bool == null) {
	//no such boolean
}


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
