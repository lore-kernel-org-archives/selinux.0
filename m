Date: Wed, 23 Apr 2003 18:01:07 -0400
From: Dave Dodge <dododge@alpha.ncsc.mil>
To: selinux@tycho.nsa.gov
Cc: dododge@alpha.ncsc.mil
Subject: Re: portability patch for char signedness
Message-Id: <20030423180107.79a79184.dododge@alpha.ncsc.mil>
In-Reply-To: <200304141459.54596.russell@coker.com.au>
References: <200304141459.54596.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 14 Apr 2003 00:59:54 -0400
Russell Coker <russell@coker.com.au> wrote:

> The attached patch fixes some char signedness issues.

> -  char c;
> +  int c_int;

> -  while ( (c = getopt(argc, argv, "k:c:s:")) != EOF) {
> -    switch (c) {
> +  while ( (c_int = getopt(argc, argv, "k:c:s:")) != EOF) {
> +    switch ((char)c_int) {

A slightly simpler fix is to just change the type of "c" to int
without renaming or casting. "getopt" returns an int, all of
the case statements are ints, and "c" is not used in any other
context.

                                        -Dave Dodge/dododge@alpha.ncsc.mil

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
