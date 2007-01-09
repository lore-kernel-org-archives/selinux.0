Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l09GHGx6010710
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 11:17:16 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l09GI5PN028163
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 16:18:05 GMT
Message-ID: <45A3C035.5020203@tresys.com>
Date: Tue, 09 Jan 2007 11:17:57 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] allow semodule -i to accept list of modules
References: <1168292627.14203.2.camel@localhost.localdomain>
In-Reply-To: <1168292627.14203.2.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> The following patch allows semodule to handle a list of modules for
> installation (i.e., semodule -i *.pp now works).
>
> Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>
>
>   
Acked-By: Joshua Brindle <jbrindle@tresys.com>
> diff -r e37f9d8d6611 policycoreutils/semodule/semodule.c
> --- a/policycoreutils/semodule/semodule.c	Mon Jan 08 15:00:14 2007 -0500
> +++ b/policycoreutils/semodule/semodule.c	Mon Jan 08 16:37:23 2007 -0500
> @@ -225,15 +225,6 @@ static void parse_command_line(int argc,
>  			}
>  		}
>  	}
> -	if (optind < argc) {
> -		fprintf(stderr, "Extraneous arguments:  ");
> -		while (optind < argc)
> -			fprintf(stderr, "%s", argv[optind++]);
> -		fprintf(stderr, "\n");
> -		usage(argv[0]);
> -		cleanup();
> -		exit(1);
> -	}
>  	if ((build || reload) && num_commands) {
>  		fprintf(stderr,
>  			"build or reload should not be used with other commands\n");
> @@ -244,6 +235,24 @@ static void parse_command_line(int argc,
>  		fprintf(stderr, "At least one mode must be specified.\n");
>  		usage(argv[0]);
>  		exit(1);
> +	}
> +
> +	if (optind < argc) {
> +		/* if -i was the last command treat any remaining
> +		 * arguments as modules to allow 'semodule -i *.pp' to
> +		 * work as expected.
> +		 */
> +		if (commands[num_commands - 1].mode == INSTALL_M) {
> +			while (optind < argc)
> +				set_mode(INSTALL_M, argv[optind++]);
> +		} else {
> +			fprintf(stderr, "unknown additional arguments:\n");
> +			while (optind < argc)
> +				fprintf(stderr, " %s", argv[optind++]);
> +			fprintf(stderr, "\n\n");
> +			usage(argv[0]);
> +			exit(1);
> +		}
>  	}
>  }
>  
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>
>   



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
