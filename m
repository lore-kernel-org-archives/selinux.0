MIME-Version: 1.0
Date: Sat, 7 Nov 2015 20:29:54 -0800
Message-ID: <CAFJ0LnG+=byi92+d6EWyJDikgxxUjX8E1WAHbu4ZBix-65mMYw@mail.gmail.com>
Subject: neverallow rules and self negation
From: Nick Kralevich <nnk@google.com>
To: SELinux <Selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Consider the following rules:

  attribute foo;
  type asdf, foo;
  type asdf2, foo;
  allow asdf self:dir search;
  neverallow foo { foo -self }:dir search;

This particular policy fails to compile with the following error:

libsepol.report_failure: neverallow on line XXX of XXX (or line XXX of
policy.conf) violated by allow asdf asdf:dir { search };
libsepol.check_assertions: 1 neverallow failures occurred

The intent of the neverallow rule is to prohibit cross domain access
to some resource, but allow access within the same domain. Something
like:

  neverallow asdf { foo -asdf }:dir search;
  neverallow asdf2 { foo -asdf2 }:dir search;

1) Is the behavior described above a bug or working as intended?
2) Is there a way to write a neverallow rule where the target uses
"-self", and if so, what does it mean?

-- 
Nick Kralevich | Android Security | nnk@google.com | 650.214.4037
