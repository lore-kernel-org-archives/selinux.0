Subject: Re: bug#24541: runcon tty hijacking via TIOCSTI ioctl
To: up201407890@alunos.dcc.fc.up.pt
References: <20160925133955.72163x0kftak7yqs@webmail.alunos.dcc.fc.up.pt>
 <ad807471-3549-b9fa-e718-8110e6a768b2@cs.ucla.edu>
 <20160926083811.30682dgg5kr92vr4@webmail.alunos.dcc.fc.up.pt>
Cc: 24541-done@debbugs.gnu.org, SE-Linux <SELinux@tycho.nsa.gov>
From: Paul Eggert <eggert@cs.ucla.edu>
Message-ID: <cd8c8f0b-4aee-e224-8816-6e835eee2bac@cs.ucla.edu>
Date: Mon, 26 Sep 2016 08:53:34 -0700
MIME-Version: 1.0
In-Reply-To: <20160926083811.30682dgg5kr92vr4@webmail.alunos.dcc.fc.up.pt>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

> "I don't think we need to fix this for runcon, as it isn't as
> sandboxing tool like sandbox, and the loss of job control would likely
> be much more noticeable for runcon."

Thanks, closing the debbugs bug report.
