Message-ID: <54DB5D87.20405@tresys.com>
Date: Wed, 11 Feb 2015 08:47:51 -0500
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
To: Colin Powers <Colin.Powers@nexor.com>, "SELinux@tycho.nsa.gov"
 <SELinux@tycho.nsa.gov>
Subject: Re: keywords in .fc files
References: <AMSPR03MB632C591E8AF6DBA1219361C9E250@AMSPR03MB632.eurprd03.prod.outlook.com>
In-Reply-To: <AMSPR03MB632C591E8AF6DBA1219361C9E250@AMSPR03MB632.eurprd03.prod.outlook.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 2/11/2015 5:57 AM, Colin Powers wrote:
> Hi all,
> 
> We are trying in a .fc file to assign a label to a directory path containing the word 'include', e.g.
> 
> /opt/mydir/include(/.*)?		-d	gen_context(system_u:object_r:my_context_t,s0)
> 
> However it seems 'include(...)' is interpreted as a keyword/macro which causes a compilation error:
> `/.*': No such file or directory
> 
> Is there a way around this, other than by doing something funny with the regex, like wildcarding one of the letters?

You can do a "stupid m4 trick", by adding in an empty string
(backtick-apostraphe) before the open parenthesis:

/opt/mydir/include`'(/.*)?


For example:

$ cat test
/opt/mydir/include`'(/.*)?

$ m4 test
/opt/mydir/include(/.*)?


Note: Reference Policy questions should be asked on the refpolicy list
(http://oss.tresys.com/mailman/listinfo/refpolicy)

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
