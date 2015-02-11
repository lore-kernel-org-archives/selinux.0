From: Colin Powers <Colin.Powers@nexor.com>
To: "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
Subject: keywords in .fc files
Date: Wed, 11 Feb 2015 10:57:19 +0000
Message-ID: <AMSPR03MB632C591E8AF6DBA1219361C9E250@AMSPR03MB632.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi all,

We are trying in a .fc file to assign a label to a directory path containing the word 'include', e.g.

/opt/mydir/include(/.*)?		-d	gen_context(system_u:object_r:my_context_t,s0)

However it seems 'include(...)' is interpreted as a keyword/macro which causes a compilation error:
`/.*': No such file or directory

Is there a way around this, other than by doing something funny with the regex, like wildcarding one of the letters?

Cheers
Colin
