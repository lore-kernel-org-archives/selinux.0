Message-ID: <54DB5CDB.8070407@tycho.nsa.gov>
Date: Wed, 11 Feb 2015 08:44:59 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Colin Powers <Colin.Powers@nexor.com>,
 "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
Subject: Re: keywords in .fc files
References: <AMSPR03MB632C591E8AF6DBA1219361C9E250@AMSPR03MB632.eurprd03.prod.outlook.com>
In-Reply-To: <AMSPR03MB632C591E8AF6DBA1219361C9E250@AMSPR03MB632.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/11/2015 05:57 AM, Colin Powers wrote:
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

I'm guessing that this is a result of passing the .fc file through m4 to
expand macros like gen_context().  So perhaps you could just quote it to
avoid expansion by m4?
