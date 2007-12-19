Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBJFTO2g000506
	for <selinux@tycho.nsa.gov>; Wed, 19 Dec 2007 10:29:24 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBJFTNlg009536
	for <selinux@tycho.nsa.gov>; Wed, 19 Dec 2007 15:29:23 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lBJFTAwF019277
	for <selinux@tycho.nsa.gov>; Wed, 19 Dec 2007 10:29:10 -0500
Subject: Re: Fixes for sepolgen to parse Fedora 9 Policy
From: Karl MacMillan <kmacmill@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4768F1FF.5020206@redhat.com>
References: <4768F1FF.5020206@redhat.com>
Content-Type: text/plain
Date: Wed, 19 Dec 2007 10:29:07 -0500
Message-Id: <1198078147.12779.2.camel@clapton.mentalrootkit.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-12-19 at 05:27 -0500, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
>       Handle ifelse statements - Not sure if how we want to handle this,
>  right now just pass

That's probably fine for now.

>       Handle refpolicywarn inside of define - Just removing the line

Chris - for what it's worth, these things are almost impossible to parse
correctly.

>       Add init.if and inetd.if into parse - They seem to work

But old versions definitely don't, so you would be breaking on old
policies.

>       Add parse_file to syntax error message - Easier to debug policy
> problems

Can you resend without the blacklist changes?

Karl

> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.7 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> 
> iD8DBQFHaPH+rlYvE4MpobMRAt0GAJ0Tors5vz+YB25VfBrADMxTtkKnFwCeJi7w
> SmJjRXtLVJkg4rA6HuL1UmY=
> =Bavy
> -----END PGP SIGNATURE-----
> plain text document attachment (diffsepol)
> diff --exclude-from=exclude -N -u -r nsasepolgen/src/sepolgen/refparser.py policycoreutils-2.0.32/sepolgen-1.0.10/src/sepolgen/refparser.py
> --- nsasepolgen/src/sepolgen/refparser.py	2007-09-13 08:21:11.000000000 -0400
> +++ policycoreutils-2.0.32/sepolgen-1.0.10/src/sepolgen/refparser.py	2007-12-19 05:21:44.000000000 -0500
> @@ -118,6 +118,7 @@
>      'TEMPLATE',
>      'GEN_CONTEXT',
>      #   m4
> +    'IFELSE',
>      'IFDEF',
>      'IFNDEF',
>      'DEFINE'
> @@ -174,6 +175,7 @@
>      'template' : 'TEMPLATE',
>      'gen_context' : 'GEN_CONTEXT',
>      # M4
> +    'ifelse' : 'IFELSE',
>      'ifndef' : 'IFNDEF',
>      'ifdef' : 'IFDEF',
>      'define' : 'DEFINE'
> @@ -220,6 +222,12 @@
>      # Ignore all comments
>      t.lexer.lineno += 1
>  
> +def t_refpolicywarn1(t):
> +    r'define.*refpolicywarn\(.*\n'
> +    # Ignore refpolicywarn statements - they sometimes
> +    # contain text that we can't parse.
> +    t.skip(1)
> +
>  def t_refpolicywarn(t):
>      r'refpolicywarn\(.*\n'
>      # Ignore refpolicywarn statements - they sometimes
> @@ -258,6 +266,7 @@
>  m = None
>  #   error is either None (indicating no error) or a string error message.
>  error = None
> +parse_file = ""
>  #   spt is the support macros (e.g., obj/perm sets) - it is an instance of
>  #     refpolicy.SupportMacros and should always be present during parsing
>  #     though it may not contain any macros.
> @@ -382,6 +391,19 @@
>          collect(p[12], x, val=False)
>      p[0] = [x]
>  
> +def p_ifelse(p):
> +    '''ifelse : IFELSE OPAREN TICK IDENTIFIER SQUOTE COMMA COMMA TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
> +              | IFELSE OPAREN TICK IDENTIFIER SQUOTE COMMA TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
> +    '''
> +#    x = refpolicy.IfDef(p[4])
> +#    v = True
> +#    collect(p[8], x, val=v)
> +#    if len(p) > 12:
> +#        collect(p[12], x, val=False)
> +#    p[0] = [x]
> +    pass
> +
> +
>  def p_ifdef(p):
>      '''ifdef : IFDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
>               | IFNDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
> @@ -446,6 +468,7 @@
>                | optional_policy
>                | tunable_policy
>                | ifdef
> +              | ifelse
>                | conditional
>      '''
>      p[0] = p[1]
> @@ -844,7 +867,8 @@
>  
>  def p_error(tok):
>      global error
> -    error = "Syntax error on line %d %s [type=%s]" % (tok.lineno, tok.value, tok.type)
> +    global parse_file
> +    error = "%s: Syntax error on line %d %s [type=%s]" % (parse_file, tok.lineno, tok.value, tok.type)
>      print error
>  
>  def prep_spt(spt):
> @@ -892,7 +916,7 @@
>  def list_headers(root):
>      modules = []
>      support_macros = None
> -    blacklist = ["init.if", "inetd.if", "uml.if", "thunderbird.if"]
> +    blacklist = ["uml.if", "thunderbird.if"]
>  
>      for dirpath, dirnames, filenames in os.walk(root):
>          for name in filenames:
> @@ -941,12 +965,14 @@
>              output.write(msg)
>  
>      def parse_file(f, module, spt=None):
> +        global parse_file
>          if debug:
>              o("parsing file %s\n" % f)
>          try:
>              fd = open(f)
>              txt = fd.read()
>              fd.close()
> +            parse_file = f
>              parse(txt, module, spt, debug)
>          except IOError, e:
>              return


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
